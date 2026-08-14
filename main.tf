locals {
  zone_name         = "torosaba.net"
  github_pages_host = "toro-server.github.io"
  mc_subdomains     = toset(["minuma", "lgb", "doro", "toto"])
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
  content = var.toropon_ip
  type    = "A"
  proxied = false
  ttl     = 1
}

resource "cloudflare_record" "lgb_a" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "lgb"
  content = var.toropon_ip
  type    = "A"
  proxied = false
  ttl     = 1
}

resource "cloudflare_record" "doro_a" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "doro"
  content = var.toropon_ip
  type    = "A"
  proxied = false
  ttl     = 1
}

resource "cloudflare_record" "toto_a" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "toto"
  content = var.toropon_ip
  type    = "A"
  proxied = false
  ttl     = 1
}

resource "cloudflare_record" "root_a" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = local.zone_name
  content = var.toropon_ip
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

moved {
  from = cloudflare_record.minecraft_srv_minuma
  to   = cloudflare_record.minecraft_srv["minuma"]
}

moved {
  from = cloudflare_record.minecraft_srv_lgb
  to   = cloudflare_record.minecraft_srv["lgb"]
}

moved {
  from = cloudflare_record.minecraft_srv_doro
  to   = cloudflare_record.minecraft_srv["doro"]
}

moved {
  from = cloudflare_record.minecraft_srv_toto
  to   = cloudflare_record.minecraft_srv["toto"]
}

resource "cloudflare_record" "minecraft_srv" {
  for_each = local.mc_subdomains
  zone_id  = cloudflare_zone.torosaba_net.id
  name     = "_minecraft._tcp.${each.value}"
  type     = "SRV"
  proxied  = false
  ttl      = 1
  data {
    service  = "_minecraft"
    proto    = "_tcp"
    name     = each.value
    priority = 50
    weight   = 100
    port     = 27248
    target   = "${each.value}.${local.zone_name}"
  }
}

resource "cloudflare_record" "minecraft_srv_root" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "_minecraft._tcp"
  type    = "SRV"
  proxied = false
  ttl     = 1
  data {
    service  = "_minecraft"
    proto    = "_tcp"
    name     = local.zone_name
    priority = 50
    weight   = 100
    port     = 27248
    target   = local.zone_name
  }
}

resource "cloudflare_record" "github_pages_challenge" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "_github-pages-challenge-toro-server"
  content = var.gh_pages_challenge_content
  type    = "TXT"
  proxied = false
  ttl     = 1
}
