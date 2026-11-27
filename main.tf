locals {
  zone_name         = "torosaba.net"
  github_pages_host = "toro-server.github.io"
}

resource "cloudflare_zone" "torosaba_net" {
  account = {
    id = var.cloudflare_account_id
  }
  name = local.zone_name
  type = "full"
}

# ゲーム入口と公開サービスの A / AAAA。アドレスは変数 marumasa_ip / marumasa_ipv6 で管理し、
# Terraform が content を含めて管理する。アドレスが変わった場合は変数の値を更新して Apply する
resource "cloudflare_dns_record" "minuma_a" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "minuma"
  content = var.marumasa_ip
  type    = "A"
  proxied = false
  ttl     = 300
}

resource "cloudflare_dns_record" "minuma_aaaa" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "minuma"
  content = var.marumasa_ipv6
  type    = "AAAA"
  proxied = false
  ttl     = 300
}

resource "cloudflare_dns_record" "lgb_a" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "lgb"
  content = var.marumasa_ip
  type    = "A"
  proxied = false
  ttl     = 300
}

resource "cloudflare_dns_record" "lgb_aaaa" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "lgb"
  content = var.marumasa_ipv6
  type    = "AAAA"
  proxied = false
  ttl     = 300
}

resource "cloudflare_dns_record" "doro_a" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "doro"
  content = var.marumasa_ip
  type    = "A"
  proxied = false
  ttl     = 300
}

resource "cloudflare_dns_record" "doro_aaaa" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "doro"
  content = var.marumasa_ipv6
  type    = "AAAA"
  proxied = false
  ttl     = 300
}

resource "cloudflare_dns_record" "toto_a" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "toto"
  content = var.marumasa_ip
  type    = "A"
  proxied = false
  ttl     = 300
}

resource "cloudflare_dns_record" "toto_aaaa" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "toto"
  content = var.marumasa_ipv6
  type    = "AAAA"
  proxied = false
  ttl     = 300
}

resource "cloudflare_dns_record" "root_a" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = local.zone_name
  content = var.marumasa_ip
  type    = "A"
  proxied = false
  ttl     = 300
}

resource "cloudflare_dns_record" "root_aaaa" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = local.zone_name
  content = var.marumasa_ipv6
  type    = "AAAA"
  proxied = false
  ttl     = 300
}

# 公式サイト (TORO-Server/TORO-Website) は GitHub Pages で www に置く。
# apex は Minecraft の接続先なのでプロキシできず、www への転送は自宅サーバーの 80/443 で行う
resource "cloudflare_dns_record" "www_cname" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "www"
  content = local.github_pages_host
  type    = "CNAME"
  proxied = false
  ttl     = 1
}

# Wiki (TORO-Server/TORO-Wiki) も GitHub Pages
resource "cloudflare_dns_record" "wiki_cname" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "wiki"
  content = local.github_pages_host
  type    = "CNAME"
  proxied = false
  ttl     = 1
}

# 地図 (TORO-Server/TORO-WebMap) の静的な画面は GitHub Pages。API は api.torosaba.net/map/v1 (Tunnel → 入り口のプロキシ)
resource "cloudflare_dns_record" "map_cname" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "map"
  content = local.github_pages_host
  type    = "CNAME"
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "pass_api_aaaa" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "pass-api"
  content = var.marumasa_ipv6
  type    = "AAAA"
  proxied = true
  ttl     = 300
}

resource "cloudflare_dns_record" "pass_api_a" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "pass-api"
  content = var.marumasa_ip
  type    = "A"
  proxied = true
  ttl     = 300
}

# 3D 地図 (TORO-Server/TORO-3D-WebMap) の静的な画面は GitHub Pages。公開のホスト名は 3d-map だけ (3d という名前は使わない)。
# API は api.torosaba.net/map3d/v1。以前は Tunnel (従来の BlueMap の画面) に向けていた。戻すときはこの変更を revert する
resource "cloudflare_dns_record" "bluemap_cname" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "3d-map"
  content = local.github_pages_host
  type    = "CNAME"
  proxied = false
  ttl     = 1
}

# MarumaSign の看板の画像などのアセットサーバー (DNS のみの AAAA で自前のサーバーへ直接。看板の許可判定が要求元 IPv6 を見るため Tunnel を介さない)
resource "cloudflare_dns_record" "assets_aaaa" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "assets"
  content = var.marumasa_ipv6
  type    = "AAAA"
  proxied = false
  ttl     = 300
}

resource "cloudflare_dns_record" "assets_a" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "assets"
  content = var.marumasa_ip
  type    = "A"
  proxied = false
  ttl     = 300
}

resource "cloudflare_dns_record" "sound_cname" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "sound"
  content = local.github_pages_host
  type    = "CNAME"
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "status_cname" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "status"
  content = local.github_pages_host
  type    = "CNAME"
  proxied = false
  ttl     = 1
}

resource "cloudflare_dns_record" "github_pages_challenge" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "_github-pages-challenge-toro-server"
  content = var.gh_pages_challenge_content
  type    = "TXT"
  proxied = false
  ttl     = 1
}

# 共通認証 (認証サービス。DNS のみの AAAA で自前のサーバーへ直接)
resource "cloudflare_dns_record" "auth_aaaa" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "auth"
  content = var.marumasa_ipv6
  type    = "AAAA"
  proxied = true
  ttl     = 300
}

resource "cloudflare_dns_record" "auth_a" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "auth"
  content = var.marumasa_ip
  type    = "A"
  proxied = true
  ttl     = 300
}

# AI コネクタ (認証サービス。DNS のみの AAAA で自前のサーバーへ直接)
resource "cloudflare_dns_record" "mcp_aaaa" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "mcp"
  content = var.marumasa_ipv6
  type    = "AAAA"
  proxied = false
  ttl     = 300
}

resource "cloudflare_dns_record" "mcp_a" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "mcp"
  content = var.marumasa_ip
  type    = "A"
  proxied = false
  ttl     = 300
}

# REST API (認証サービス。DNS のみの AAAA で自前のサーバーへ直接)
resource "cloudflare_dns_record" "api_aaaa" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "api"
  content = var.marumasa_ipv6
  type    = "AAAA"
  proxied = true
  ttl     = 300
}

resource "cloudflare_dns_record" "api_a" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "api"
  content = var.marumasa_ip
  type    = "A"
  proxied = true
  ttl     = 300
}

# なりすましメール防止のための SPF レコード (メール送信不許可)
resource "cloudflare_dns_record" "spf_record" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = local.zone_name
  content = "v=spf1 -all"
  type    = "TXT"
  proxied = false
  ttl     = 1
}

# なりすましメール防止のための DMARC レコード (不正メール完全拒絶)
resource "cloudflare_dns_record" "dmarc_record" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "_dmarc"
  content = "v=DMARC1; p=reject; sp=reject; aspf=s; adkim=s;"
  type    = "TXT"
  proxied = false
  ttl     = 1
}

# Google Search Console ドメインプロパティ所有権確認用 TXT レコード
resource "cloudflare_dns_record" "google_site_verification" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = local.zone_name
  content = var.gsc_site_verification_txt
  type    = "TXT"
  proxied = false
  ttl     = 1
}

# cloudflare provider v5 migration: move v4 cloudflare_record addresses to cloudflare_dns_record
moved {
  from = cloudflare_record.www_cname
  to   = cloudflare_dns_record.www_cname
}
moved {
  from = cloudflare_record.wiki_cname
  to   = cloudflare_dns_record.wiki_cname
}
moved {
  from = cloudflare_record.map_cname
  to   = cloudflare_dns_record.map_cname
}
moved {
  from = cloudflare_record.pass_api_cname
  to   = cloudflare_dns_record.pass_api_cname
}
moved {
  from = cloudflare_record.bluemap_cname
  to   = cloudflare_dns_record.bluemap_cname
}
moved {
  from = cloudflare_record.assets_cname
  to   = cloudflare_dns_record.assets_cname
}
moved {
  from = cloudflare_record.sound_cname
  to   = cloudflare_dns_record.sound_cname
}
moved {
  from = cloudflare_record.status_cname
  to   = cloudflare_dns_record.status_cname
}
moved {
  from = cloudflare_record.github_pages_challenge
  to   = cloudflare_dns_record.github_pages_challenge
}
moved {
  from = cloudflare_record.auth_cname
  to   = cloudflare_dns_record.auth_cname
}
moved {
  from = cloudflare_record.mcp_cname
  to   = cloudflare_dns_record.mcp_cname
}
moved {
  from = cloudflare_record.api_cname
  to   = cloudflare_dns_record.api_cname
}
moved {
  from = cloudflare_record.spf_record
  to   = cloudflare_dns_record.spf_record
}
moved {
  from = cloudflare_record.dmarc_record
  to   = cloudflare_dns_record.dmarc_record
}
