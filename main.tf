resource "cloudflare_zone" "torosaba_net" {
  account_id = var.cloudflare_account_id
  zone       = "torosaba.net"
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

resource "cloudflare_record" "root_a" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "torosaba.net"
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
  content = "toro-server.github.io"
  type    = "CNAME"
  proxied = false
  ttl     = 1
}

resource "cloudflare_record" "status_cname" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "status"
  content = "toro-server.github.io"
  type    = "CNAME"
  proxied = false
  ttl     = 1
}

resource "cloudflare_record" "minecraft_srv_minuma" {
  zone_id  = cloudflare_zone.torosaba_net.id
  name     = "_minecraft._tcp.minuma"
  type     = "SRV"
  proxied  = false
  ttl      = 1
  priority = 50
  data {
    service  = "_minecraft"
    proto    = "_tcp"
    name     = "minuma"
    priority = 50
    weight   = 100
    port     = 27248
    target   = "minuma.torosaba.net"
  }
}

resource "cloudflare_record" "minecraft_srv_root" {
  zone_id  = cloudflare_zone.torosaba_net.id
  name     = "_minecraft._tcp"
  type     = "SRV"
  proxied  = false
  ttl      = 1
  priority = 50
  data {
    service  = "_minecraft"
    proto    = "_tcp"
    name     = "torosaba.net"
    priority = 50
    weight   = 100
    port     = 27248
    target   = "torosaba.net"
  }
}

resource "cloudflare_record" "github_pages_challenge" {
  zone_id = cloudflare_zone.torosaba_net.id
  name    = "_github-pages-challenge-toro-server"
  content = var.github_pages_challenge_content
  type    = "TXT"
  proxied = false
  ttl     = 1
}
