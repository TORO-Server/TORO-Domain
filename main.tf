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

resource "cloudflare_record" "root_a" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = local.zone_name
  content = var.marumasa_ip
  type    = "A"
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
