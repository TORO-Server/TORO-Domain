terraform {
  # HCP Terraform (Terraform Cloud) によるリモートステート管理
  # 移行手順:
  # 1. https://app.terraform.io でアカウント・Organizationを作成
  # 2. 以下の "your-org-name" を作成したOrganization名に変更
  cloud {
    organization = "your-org-name"
    workspaces {
      name = "torosaba-net"
    }
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}
