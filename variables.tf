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

variable "marumasa_ipv6" {
  description = "Global IPv6 address of the server owner (marumasa)"
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

variable "tunnel_origin_services" {
  description = "Origin service URL (internal address) that the torosaba.net Tunnel forwards every hostname to"
  type = object({
    edge = string
  })
  sensitive = true
}

variable "gsc_site_verification_txt" {
  description = "Google Search Console domain verification TXT record content"
  type        = string
  sensitive   = true
}