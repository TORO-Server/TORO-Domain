# torosaba.net ドメイン管理 (Terraform)

`torosaba.net` ドメイン設定を Terraform で管理します。

## 事前準備

1. **Terraform のインストール**

   既にインストール済みでない場合は、以下のコマンドでインストール可能です。

   ```powershell
   winget install Hashicorp.Terraform
   ```

1. **認証資格情報の設定**

   `terraform.tfvars.example` を参考に `terraform.tfvars` ファイルを作成し認証資格情報などを設定してください。

   ```powershell
   cp terraform.tfvars.example terraform.tfvars
   ```

## 基本操作

### 初期化

初回、またはプラグインの更新が必要な際に実行します。

```powershell
terraform init
```

### 変更の確認

現時点の設定（`.tf` ファイル）と実際の Cloudflare 上の設定の差分を確認します。

```powershell
terraform plan
```

### 変更の適用

```powershell
terraform apply
```
