locals {
  zone_name         = "torosaba.net"
  github_pages_host = "toro-server.github.io"
}

resource "cloudflare_zone" "torosaba_net" {
  account_id = var.cloudflare_account_id
  zone       = local.zone_name
  plan       = "free"
  type       = "full"
}

resource "cloudflare_record" "minuma_a" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "minuma"
  content = var.marumasa_ip
  type    = "A"
  proxied = false
  ttl     = 1
}

resource "cloudflare_record" "lgb_a" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "lgb"
  content = var.marumasa_ip
  type    = "A"
  proxied = false
  ttl     = 1
}

resource "cloudflare_record" "doro_a" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "doro"
  content = var.marumasa_ip
  type    = "A"
  proxied = false
  ttl     = 1
}

resource "cloudflare_record" "toto_a" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "toto"
  content = var.marumasa_ip
  type    = "A"
  proxied = false
  ttl     = 1
}

# 公式サイト (TORO-Server/TORO-Website: GitHub Pages) の apex から www へのリダイレクト用 A / AAAA レコード
resource "cloudflare_record" "root_a" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = local.zone_name
  content = "185.199.108.153"
  type    = "A"
  proxied = false
  ttl     = 1
}

resource "cloudflare_record" "root_a_2" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = local.zone_name
  content = "185.199.109.153"
  type    = "A"
  proxied = false
  ttl     = 1
}

resource "cloudflare_record" "root_a_3" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = local.zone_name
  content = "185.199.110.153"
  type    = "A"
  proxied = false
  ttl     = 1
}

resource "cloudflare_record" "root_a_4" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = local.zone_name
  content = "185.199.111.153"
  type    = "A"
  proxied = false
  ttl     = 1
}

resource "cloudflare_record" "root_aaaa_1" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = local.zone_name
  content = "2606:50c0:8000::153"
  type    = "AAAA"
  proxied = false
  ttl     = 1
}

resource "cloudflare_record" "root_aaaa_2" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = local.zone_name
  content = "2606:50c0:8001::153"
  type    = "AAAA"
  proxied = false
  ttl     = 1
}

resource "cloudflare_record" "root_aaaa_3" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = local.zone_name
  content = "2606:50c0:8002::153"
  type    = "AAAA"
  proxied = false
  ttl     = 1
}

resource "cloudflare_record" "root_aaaa_4" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = local.zone_name
  content = "2606:50c0:8003::153"
  type    = "AAAA"
  proxied = false
  ttl     = 1
}

# 公式サイト (TORO-Server/TORO-Website) は GitHub Pages で www に置く。
resource "cloudflare_record" "www_cname" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "www"
  content = local.github_pages_host
  type    = "CNAME"
  proxied = false
  ttl     = 1
}

# Wiki (TORO-Server/TORO-Wiki) も GitHub Pages
resource "cloudflare_record" "wiki_cname" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "wiki"
  content = local.github_pages_host
  type    = "CNAME"
  proxied = false
  ttl     = 1
}

resource "cloudflare_record" "map_cname" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "map"
  content = var.argotunnel_cname_target
  type    = "CNAME"
  proxied = true
  ttl     = 1
}

resource "cloudflare_record" "pass_api_cname" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "pass-api"
  content = var.argotunnel_cname_target
  type    = "CNAME"
  proxied = true
  ttl     = 1
}

resource "cloudflare_record" "bluemap_cname" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "3d-map"
  content = var.argotunnel_cname_target
  type    = "CNAME"
  proxied = true
  ttl     = 1
  # Tunnel の公開ホスト名の登録で同じレコードが先に作られていたため、既存のものを引き継ぐ
  allow_overwrite = true
}

# MarumaSign の看板の画像などのアセットサーバー (toro-nginx → toro-map-web)
resource "cloudflare_record" "assets_cname" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "assets"
  content = var.argotunnel_cname_target
  type    = "CNAME"
  proxied = true
  ttl     = 1
  # Tunnel の公開ホスト名の登録で同じレコードが先に作られていたため、既存のものを引き継ぐ
  allow_overwrite = true
}

resource "cloudflare_record" "sound_cname" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "sound"
  content = local.github_pages_host
  type    = "CNAME"
  proxied = false
  ttl     = 1
}

resource "cloudflare_record" "status_cname" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "status"
  content = local.github_pages_host
  type    = "CNAME"
  proxied = false
  ttl     = 1
}

resource "cloudflare_record" "github_pages_challenge" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "_github-pages-challenge-toro-server"
  content = var.gh_pages_challenge_content
  type    = "TXT"
  proxied = false
  ttl     = 1
}

# Auth Worker (認証および共通 API ゲートウェイ)
resource "cloudflare_record" "auth_cname" {
  zone_id         = cloudflare_zone.torosaba_net.id
  name            = "auth"
  content         = "toro-auth.marumasa.workers.dev"
  type            = "CNAME"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}

# MCP Worker (AI コネクタ用エンドポイント)
resource "cloudflare_record" "mcp_cname" {
  zone_id         = cloudflare_zone.torosaba_net.id
  name            = "mcp"
  content         = "toro-auth.marumasa.workers.dev"
  type            = "CNAME"
  proxied         = true
  ttl             = 1
  allow_overwrite = true
}
