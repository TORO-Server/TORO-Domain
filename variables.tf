variable "cloudflare_api_token" {
  description = "Cloudflare API Token"
  type        = string
  sensitive   = true
}

variable "cloudflare_account_id" {
  description = "Cloudflare Account ID"
  type        = string
  sensitive   = true
}

variable "toropon_ip" {
  description = "Global IP address for toropon"
  type        = string
  sensitive   = true
}

variable "argotunnel_cname_target" {
  description = "CNAME target for Cloudflare Tunnel"
  type        = string
  sensitive   = true
}

variable "gh_pages_challenge_content" {
  description = "Content for GitHub Pages challenge TXT record"
  type        = string
  sensitive   = true
}
