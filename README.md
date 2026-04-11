# TORO-Domain

Cloudflare を利用して `torosaba.net` ドメインの DNS レコードを管理するための Terraform

## GitHub Secrets の設定

| シークレット名 | 説明 |
| :--- | :--- |
| `CLOUDFLARE_API_TOKEN` | Cloudflare の API トークン（DNS 編集権限が必要） |
| `CLOUDFLARE_ACCOUNT_ID` | Cloudflare のアカウント ID |
| `R2_ACCESS_KEY_ID` | Cloudflare R2 のアクセスキー ID |
| `R2_SECRET_ACCESS_KEY` | Cloudflare R2 のシークレットアクセスキー |
| `TOROPON_IP` | とろぽん のグローバルIPアドレス |
| `ARGOTUNNEL_CNAME_TARGET` | Cloudflare Tunnel 用の CNAME ターゲット |
| `GH_PAGES_CHALLENGE_CONTENT` | GitHub Pages チャレンジ用の TXT レコード内容 |
