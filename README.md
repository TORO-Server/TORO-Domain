# TORO-Domain

TORO のドメインの DNS (名前から接続先を引く表) の記録を、Cloudflare 上で管理するための Terraform (設定をファイルに書いて自動で反映する道具) の設定です。

## DNS の設定を公開している理由

DNS の設定は、調べれば誰でも見られる情報なので公開しています。

IP アドレスなどをファイルに直接書かず変数で受け取るのは、値を変えやすくするためです。DNS に載る値は誰でも調べられるので、変数にしても秘密にはなりません。値は GitHub の秘密の設定 (下の表) に置き、この置き場には書きません。

## 自動検査と反映

- 変更の提案 (プルリクエスト) では、Terraform の検査 (`validate`) と計画 (`plan`) が動きます。ここには認証情報を渡しません。計画はダミーの値で、構成だけを確かめます。実際の記録との差は見ません。
- 認証情報を使うのは、`main` へ反映されたときに動く `terraform apply` だけです。この処理は GitHub の環境 `production` で動きます。
- `production` に必須の確認者を設定し、下の秘密の設定を置き場全体から `production` に移すと、別のブランチの処理からは読めなくなります。
- Terraform の部品 (プロバイダー) のバージョンを固定するファイルは、Dependabot (GitHub の依存部品を自動で更新する道具) などの変更の提案で更新します。反映の処理は書き換えません。

処理の中身の正本は [.github/workflows/](.github/workflows/) です。

## GitHub の秘密の設定

| 名前 | 説明 |
| :--- | :--- |
| `CLOUDFLARE_API_TOKEN` | Cloudflare の API トークン (DNS を編集できる権限が必要) |
| `CLOUDFLARE_ACCOUNT_ID` | Cloudflare のアカウント ID |
| `R2_ACCESS_KEY_ID` | Cloudflare R2 (Terraform の状態の保存先) のアクセスキー ID |
| `R2_SECRET_ACCESS_KEY` | Cloudflare R2 のシークレットアクセスキー |
| `MARUMASA_IP` | サーバーのグローバル IP アドレス |
| `MARUMASA_IPV6` | サーバーのグローバル IPv6 アドレス (AAAA 初回作成用。以後の変更は `ignore_changes = [content]`) |
| `ARGOTUNNEL_CNAME_TARGET` | Cloudflare Tunnel 用の CNAME (別の名前への案内を示す DNS の記録) の接続先 |
| `GH_PAGES_CHALLENGE_CONTENT` | GitHub Pages の所有確認用の TXT (文字列を載せる DNS の記録) 記録の内容 |
| `TUNNEL_ORIGIN_SERVICES` | Cloudflare Tunnel の転送先 (内部のサービスのアドレス) を JSON で書いたもの。形は `{"edge":"http://ホスト名:ポート"}`。全ホスト名がこの 1 つへ向く。Terraform の変数 `tunnel_origin_services` に渡る |
