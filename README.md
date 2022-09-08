# toggl-to-habitra
Toggl のデータから HabiTra に記録するスクリプト

## 使い方
### ローカルの場合
#### 環境変数の設定
```bash
cp .env.sample .env
vim .env
```

#### 実行
```bash
ruby app.rb
```
### GitHub Actionsの場合
#### 環境変数の設定
[Settings] -> [Secrets]に以下を登録
- TOGGL_API_TOKEN: Togglのtoken
- TOGGL_WORKSPACE_ID: Togglのworkspace id
- HABITRA_ID: HabiTra の User ID
- HABITRA_PASSWORD: HabiTra の User password
