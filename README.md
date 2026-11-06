# TORO-Domain

Cloudflare を利用して `torosaba.net` ドメインの DNS レコードを管理するための Terraform

## DNS設定の公開について

DNS設定は、調べれば誰でも見ることができる情報であるため公開しています。

IPアドレスなどをソースコード内に直接記述せず変数で管理しているのは、値を変えやすくするためです。DNS に載る値は誰でも調べられるので、変数にしても秘密にはなりません。

## 認証情報の扱い

- プルリクエストの Terraform Plan と Terraform Validate には認証情報を渡しません。Plan はダミーの値で構成だけを計画します。state や実際のレコードとの差分は見ません。
- 認証情報を使うのは、`main` へのプッシュで動く Terraform Apply だけです。ジョブは GitHub の Environment `production` で動きます。
- `production` に必須レビュアーを設定し、下の secrets をリポジトリから `production` に移すと、ブランチのワークフローからは読めなくなります。
- プロバイダーのロックファイルは Dependabot などの PR で更新します。Apply は書き換えません。

## GitHub Secrets の設定

| シークレット名 | 説明 |
| :--- | :--- |
| `CLOUDFLARE_API_TOKEN` | Cloudflare の API トークン（DNS 編集権限が必要） |
| `CLOUDFLARE_ACCOUNT_ID` | Cloudflare のアカウント ID |
| `R2_ACCESS_KEY_ID` | Cloudflare R2 のアクセスキー ID |
| `R2_SECRET_ACCESS_KEY` | Cloudflare R2 のシークレットアクセスキー |
| `MARUMASA_IP` | サーバー所有者(まるまさ)のグローバルIPアドレス |
| `ARGOTUNNEL_CNAME_TARGET` | Cloudflare Tunnel 用の CNAME ターゲット |
| `GH_PAGES_CHALLENGE_CONTENT` | GitHub Pages チャレンジ用の TXT レコード内容 |
