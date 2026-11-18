#!/usr/bin/env bash
# 一時的な安全柵 (トンネルの取り込み専用)。terraform show -json の plan を引数に取る。
# 許す変更: 取り込みちょうど 2 件、トンネル構成 (ingress) の更新、
#           トンネル本体の更新のうち「差分のある属性パスの集合が account_id だけ」のもの。
# それ以外の作成、更新、削除が 1 件でもあれば exit 1。値は出力しない (出すのは件数と属性パスの名前だけ)。
set -euo pipefail
PLAN="${1:?usage: tunnel-guard.sh plan.json}"
TUNNEL='cloudflare_zero_trust_tunnel_cloudflared.torosaba_net'
CONFIG='cloudflare_zero_trust_tunnel_cloudflared_config.torosaba_net'

echo "resource_changes=$(jq '.resource_changes|length' "$PLAN") non_noop=$(jq '[.resource_changes[]|select(.change.actions!=["no-op"])]|length' "$PLAN") importing=$(jq '[.resource_changes[]|select(.change.importing!=null)]|length' "$PLAN")"

test "$(jq '[.resource_changes[]|select(.change.importing!=null)]|length' "$PLAN")" = "2" || { echo "expected exactly 2 imports; stop"; exit 1; }
test "$(jq --arg t "$TUNNEL" --arg c "$CONFIG" '[.resource_changes[]|select(.change.actions!=["no-op"] and .address!=$c and .address!=$t)]|length' "$PLAN")" = "0" || { echo "plan contains changes other than the tunnel config and the tunnel itself; stop"; exit 1; }
test "$(jq --arg c "$CONFIG" '[.resource_changes[]|select(.address==$c and (.change.actions|index("create") or index("delete")))]|length' "$PLAN")" = "0" || { echo "tunnel config would be created or deleted; stop"; exit 1; }

# トンネル本体: 変更があるなら actions は ["update"] ちょうどで、差分のある属性パスの集合が ["account_id"] ちょうどであること。
# 差分の判定: sensitive の印がある属性は「値の有無」と「印の違い」だけで見る (値そのものは比較に使わない)。
#             それ以外の属性は値を比較する。after_unknown が真の属性も差分とする。出力するのはパス名のみ。
PATHS="$(jq -c --arg t "$TUNNEL" '
  def issens($m; $k): (($m // {})[$k] // false) as $x | ($x != false and $x != {});
  [.resource_changes[]|select(.address==$t and .change.actions!=["no-op"])|.change|
    (.before // {}) as $b | (.after // {}) as $a |
    (.before_sensitive // {}) as $bs | (.after_sensitive // {}) as $as | (.after_unknown // {}) as $au |
    [(($b|keys) + ($a|keys) + ($bs|keys) + ($as|keys) + ($au|keys))|unique[] as $k |
      select(
        (if (issens($bs;$k) or issens($as;$k))
         then ((($b[$k]) == null) != (($a[$k]) == null)) or (issens($bs;$k) != issens($as;$k))
         else ($b[$k]) != ($a[$k]) end)
        or (($au[$k] // false) != false and ($au[$k] // false) != {})
      ) | $k] | sort ]' "$PLAN")"
echo "tunnel changed attribute paths: ${PATHS}"
ACTIONS="$(jq -c --arg t "$TUNNEL" '[.resource_changes[]|select(.address==$t)|.change.actions]' "$PLAN")"
if [ "$(jq --arg t "$TUNNEL" '[.resource_changes[]|select(.address==$t and .change.actions!=["no-op"])]|length' "$PLAN")" != "0" ]; then
  test "$ACTIONS" = '[["update"]]' || { echo "tunnel resource change is not a plain update; stop"; exit 1; }
  test "$PATHS" = '[["account_id"]]' || { echo "tunnel resource differs in attributes other than account_id; stop"; exit 1; }
fi
echo "guard passed"