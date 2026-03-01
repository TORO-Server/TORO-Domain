# TORO-Domain (torosaba.net ドメイン管理)

`torosaba.net` ドメインの DNS レコードや設定を Terraform で一元管理するためのリポジトリです。
このリポジトリは公開されており、コミュニティメンバーからの貢献（Pull Request）を受け付けています。

## コントリビュート方法（コミュニティ向け）

ドメイン設定の追加や変更を提案する場合は、以下の手順に従ってください。

1. **リポジトリの Fork**
   本リポジトリを自身の GitHub アカウントに Fork します。

2. **変更の作成**
   `.tf` ファイル（主に `main.tf`）を編集し、必要な DNS レコード等の追加・修正を行います。

3. **Pull Request (PR) の作成**
   変更をコミットし、本リポジトリの `main` ブランチに対して PR を作成します。
   PR を作成すると、GitHub Actions により自動的に `terraform plan` が実行され、変更内容の差分（Plan 結果）が確認できます。

4. **レビューとマージ**
   管理者が変更内容と Plan 結果をレビューします。承認され `main` ブランチにマージされると、自動的に `terraform apply` が実行され、Cloudflare 上の設定が本番環境へ反映されます。

## ローカルでの検証方法

手元で `terraform plan` などの動作確認を行う場合は、以下の手順に従ってください。

1. `terraform.tfvars.example` をコピーして `terraform.tfvars` を作成します。

   ```sh
   cp terraform.tfvars.example terraform.tfvars
   ```

2. 作成した `terraform.tfvars` に、ご自身の環境の値を設定してください。
※ `terraform.tfvars` は `.gitignore` で除外されているため、リポジトリにはコミットされません。

## セキュリティに関する注意

- 秘密情報（API トークンや Zone ID など）は管理者の GitHub Secrets を通じて安全に管理されており、本リポジトリのソースコード上には含まれていません。
- プルリクエストを作成する際は、秘密情報をコード内に直接ハードコード（直書き）しないよう十分に注意してください。
