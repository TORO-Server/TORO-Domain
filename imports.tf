# 既存のトンネルとその構成を Terraform の管理下へ取り込む (一度だけ。取り込み後は削除してよい)。
# 識別子は GitHub の秘密の設定から来る値で、ここには書かない。
# プルリクエストの計画 (認証情報なし) では、このファイルを消してから計画する
import {
  to = cloudflare_zero_trust_tunnel_cloudflared.torosaba_net
  id = "${nonsensitive(var.cloudflare_account_id)}/${nonsensitive(local.tunnel_id)}"
}

import {
  to = cloudflare_zero_trust_tunnel_cloudflared_config.torosaba_net
  id = "${nonsensitive(var.cloudflare_account_id)}/${nonsensitive(local.tunnel_id)}"
}
