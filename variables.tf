variable "cloudflare_api_token" {
  description = "Cloudflare API Token"
  type        = string
  sensitive   = true
}

variable "cloudflare_zone_id" {
  description = "Cloudflare Zone ID for torosaba.net"
  type        = string
}

variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"
  type        = string
}

variable "toropon_ip" {
  description = "Global IP address for torosaba.net (toropon)"
  type        = string
}

variable "argotunnel_cname_target" {
  description = "CNAME target for Cloudflare Argo Tunnel"
  type        = string
}

variable "github_pages_challenge_content" {
  description = "Content for GitHub Pages challenge TXT record"
  type        = string
}
