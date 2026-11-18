# torosaba.net 用の Cloudflare Tunnel 本体と、公開ホスト名の振り分け (ingress)。
# 以前はダッシュボード／API だけで管理していたものを、実際の設定を変えずに取り込んだ。
# 転送先 (内部のサービス名) は公開しない方針なので、変数 tunnel_origin_services (GitHub の秘密の設定) で受け取る。
# 取り込み (import) の指定は imports.tf にある。

locals {
  # DNS の CNAME の向き先 (<トンネルの識別子>.cfargotunnel.com) から、識別子だけを取り出す
  tunnel_id = replace(var.argotunnel_cname_target, ".cfargotunnel.com", "")
}

resource "cloudflare_zero_trust_tunnel_cloudflared" "torosaba_net" {
  account_id = var.cloudflare_account_id
  name       = "torosaba.net"
  config_src = "cloudflare"

  lifecycle {
    # 取り込んだトンネルの秘密鍵は読み出せない。構成に書かないので、差分として扱わない
    ignore_changes = [tunnel_secret]
  }
}

# 上から順に評価される。api.torosaba.net の 3 件はパス条件で分かれている (条件なしを最後に置く)
resource "cloudflare_zero_trust_tunnel_cloudflared_config" "torosaba_net" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_zero_trust_tunnel_cloudflared.torosaba_net.id

  config = {
    ingress = [
      {
        hostname       = "pass-api.${local.zone_name}"
        service        = var.tunnel_origin_services.pass_api
        origin_request = {}
      },
      {
        hostname = "3d-map.${local.zone_name}"
        service  = var.tunnel_origin_services.edge
      },
      {
        hostname = "assets.${local.zone_name}"
        service  = var.tunnel_origin_services.edge
      },
      {
        hostname = "auth.${local.zone_name}"
        service  = var.tunnel_origin_services.auth
      },
      {
        hostname = "mcp.${local.zone_name}"
        service  = var.tunnel_origin_services.mcp
      },
      {
        hostname = "api.${local.zone_name}"
        path     = "^/map/"
        service  = var.tunnel_origin_services.edge
      },
      {
        hostname = "api.${local.zone_name}"
        path     = "^/map3d/"
        service  = var.tunnel_origin_services.edge
      },
      {
        hostname = "api.${local.zone_name}"
        service  = var.tunnel_origin_services.api
      },
      {
        service        = "http_status:404"
        origin_request = {}
      },
    ]
  }
}
