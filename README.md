# 教育向けプラットフォーム

Rails 8 + Inertia.js + React + Tailwind CSSで構築された、家庭内学習向けの教育プラットフォームです。

## 📝 概要

このプラットフォームは、保護者/教師2名と生徒2名（小学生〜高校生）を対象とした家庭内学習システムです。
アクティブラーニングと分散学習を活用し、効果的な学習をサポートします。

## 🎯 主な機能

### 教師向け機能
- ✅ 教材管理（テキスト、画像、PDF、リンク）
- ✅ テスト問題管理（選択式、記述式など）
- ✅ レッスン動画管理
- ✅ コース管理
- ✅ 生徒の質問への回答
- ✅ 学習進捗確認

### 生徒向け機能
- ✅ 学習記録管理
- ✅ 学習メモ管理
- ✅ テスト結果記録
- ✅ 質問投稿機能
- ✅ 学習計画機能（分散学習対応）
- ✅ ダッシュボードで進捗確認

## 🛠️ 技術スタック

### バックエンド
- **Ruby** 3.3.6
- **Rails** 8.1.0
- **SQLite3** (開発環境)
- **Devise** (認証)

### フロントエンド
- **React** 18.2.0
- **Inertia.js** 1.0.0
- **Tailwind CSS** 3.4.0
- **esbuild** (JavaScript bundler)

## 📦 プロジェクト構成

```
.
├── app/
│   ├── controllers/
│   │   ├── application_controller.rb
│   │   ├── courses_controller.rb      # コース管理
│   │   ├── dashboard_controller.rb    # ダッシュボード
│   │   └── home_controller.rb         # ホームページ
│   ├── models/
│   │   ├── user.rb                    # ユーザー（教師/生徒/管理者）
│   │   ├── course.rb                  # コース
│   │   ├── lesson.rb                  # レッスン
│   │   ├── material.rb                # 教材
│   │   ├── video.rb                   # 動画
│   │   ├── question.rb                # テスト問題
│   │   ├── learning_record.rb         # 学習記録
│   │   ├── learning_note.rb           # 学習メモ
│   │   ├── test_result.rb             # テスト結果
│   │   ├── learning_plan.rb           # 学習計画
│   │   └── student_question.rb        # 生徒の質問
│   └── javascript/
│       ├── application.js             # Inertia.js設定
│       └── Pages/
│           └── Home.jsx               # サンプルページ
├── config/
│   ├── database.yml
│   └── routes.rb
├── db/
│   ├── migrate/                       # マイグレーション（11個）
│   ├── seeds.rb                       # サンプルデータ
│   └── schema.rb
├── NEXT_STEPS.md                      # 次の実装手順
└── README.md                          # このファイル
```

## 🚀 セットアップ

### 必要な環境

- Ruby 3.3.6
- Node.js 22.x
- Yarn 1.22.x
- SQLite3

### インストール手順

1. **リポジトリのクローン**
   ```bash
   git clone <repository-url>
   cd try-rails8-with-inertia
   ```

2. **依存関係のインストール**
   ```bash
   # Ruby gems
   bundle install

   # JavaScript packages
   yarn install
   ```

3. **データベースのセットアップ**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   ```

4. **アセットのビルド**
   ```bash
   yarn build
   yarn build:css
   ```

5. **開発サーバーの起動**
   ```bash
   bin/dev
   ```

   ブラウザで http://localhost:3000 にアクセス

## 👥 テストアカウント

シードデータで以下のアカウントが作成されます：

| 役割 | メールアドレス | パスワード | 名前 |
|------|--------------|-----------|------|
| 管理者 | admin@example.com | password123 | システム管理者 |
| 教師 | tanaka@example.com | password123 | 田中 太郎 |
| 教師 | hanako@example.com | password123 | 田中 花子 |
| 生徒 | ichiro@example.com | password123 | 田中 一郎 |
| 生徒 | jiro@example.com | password123 | 田中 次郎 |

## 📊 データベース構造

### 主要テーブル

- **users** - ユーザー（教師/生徒/管理者）
- **courses** - コース
- **lessons** - レッスン
- **materials** - 教材（Active Storage対応）
- **videos** - 動画（Active Storage対応）
- **questions** - テスト問題
- **learning_records** - 学習記録
- **learning_notes** - 学習メモ
- **test_results** - テスト結果
- **learning_plans** - 学習計画
- **student_questions** - 生徒からの質問

### ERD

```
User (role: admin/teacher/student)
  ├─ taught_courses (教師として)
  │    └─ Course
  │         └─ Lesson
  │              ├─ Material (file attached)
  │              ├─ Video (video_file attached)
  │              └─ Question
  │                   └─ TestResult (生徒の解答)
  └─ (生徒として)
       ├─ LearningRecord
       ├─ LearningNote
       ├─ TestResult
       ├─ LearningPlan
       └─ StudentQuestion
```

## 🎨 実装済み機能

### ✅ 完了
- [x] プロジェクトセットアップ
- [x] データベース設計・マイグレーション
- [x] モデル実装（11個）
- [x] Devise認証システム
- [x] シードデータ作成
- [x] 主要コントローラー（Courses, Dashboard, Home）
- [x] ルーティング設定
- [x] Inertia.js + React統合
- [x] Tailwind CSSスタイリング

### 🔄 実装中
- [ ] Reactコンポーネント
  - [ ] ダッシュボード（教師用/生徒用）
  - [ ] コース管理UI
  - [ ] レッスン表示
- [ ] 認証フローの統合
- [ ] Active Storage（ファイルアップロード）

### ⏳ 未実装
- [ ] レッスン詳細ページ
- [ ] 学習記録機能
- [ ] テスト受験機能
- [ ] 質問投稿・回答機能
- [ ] 学習計画自動生成
- [ ] 通知機能

## 📚 次のステップ

詳細な実装手順は [`NEXT_STEPS.md`](NEXT_STEPS.md) を参照してください。

### 推奨される実装順序

1. ✅ データベース・モデル（完了）
2. ✅ コントローラー基礎（完了）
3. 🔄 Reactコンポーネント（次のステップ）
4. 🔄 認証統合
5. 🔄 Active Storage
6. ⏳ 追加機能

## 🧪 テスト

```bash
# モデルテスト
rails test:models

# コントローラーテスト
rails test:controllers

# 全テスト実行
rails test
```

## 📖 ドキュメント

- [次の実装手順](NEXT_STEPS.md) - 詳細な実装ガイド
- [Inertia.js](https://inertiajs.com/) - 公式ドキュメント
- [React](https://react.dev/) - 公式ドキュメント
- [Tailwind CSS](https://tailwindcss.com/) - 公式ドキュメント

## 🛠️ 開発コマンド

```bash
# 開発サーバー起動
bin/dev

# Rails console
rails console

# データベースリセット
rails db:reset

# アセットビルド
yarn build
yarn build:css

# コードチェック
rubocop
```

## 📝 Git ブランチ

- `main` - 本番用ブランチ
- `claude/education-platform-setup-011CUXk8RGmvVzayDBA4ZP5F` - 開発ブランチ

## 🤝 貢献

このプロジェクトは家庭内使用を想定しています。

## 📄 ライセンス

Private project for family use.

## 🙏 謝辞

- Rails 8.1
- Inertia.js
- React
- Tailwind CSS
- Devise

---

**作成日:** 2025年10月27日
**最終更新:** 2025年10月27日
**バージョン:** 0.1.0 (初期開発版)
