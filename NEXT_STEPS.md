# 次のステップ - 実装ガイド

このドキュメントでは、教育向けプラットフォームの次の実装ステップについて詳しく説明します。

## 📋 目次

1. [プロジェクトの現状](#プロジェクトの現状)
2. [ステップ3: Reactコンポーネントの作成](#ステップ3-reactコンポーネントの作成)
3. [ステップ4: 認証の統合](#ステップ4-認証の統合)
4. [ステップ5: Active Storageの設定](#ステップ5-active-storageの設定)
5. [追加の機能実装](#追加の機能実装)

---

## プロジェクトの現状

### ✅ 完了済み

- Rails 8.1 + Inertia.js + React + Tailwind CSS のセットアップ
- SQLiteデータベースの設定
- 11個のモデル（User, Course, Lesson, Material, Video, Question, LearningRecord, LearningNote, TestResult, LearningPlan, StudentQuestion）
- Devise認証システムの導入
- シードデータの投入（5ユーザー、3コース、6レッスン等）
- 主要コントローラー（Courses, Dashboard, Home）
- ルーティング設定

### 🔧 現在のファイル構成

```
app/
├── controllers/
│   ├── application_controller.rb
│   ├── courses_controller.rb
│   ├── dashboard_controller.rb
│   └── home_controller.rb
├── models/
│   └── (11個のモデル)
└── javascript/
    ├── application.js (Inertia.js設定済み)
    └── Pages/
        └── Home.jsx (サンプルページ)
```

### 🎯 次に実装すべき項目

1. Reactコンポーネント（ダッシュボード、コース管理UI）
2. 認証フローの統合（ログイン/ログアウト）
3. Active Storage（ファイルアップロード）

---

## ステップ3: Reactコンポーネントの作成

### 3.1 必要なコンポーネント一覧

```
app/javascript/Pages/
├── Dashboard/
│   ├── Teacher.jsx      # 教師用ダッシュボード
│   └── Student.jsx      # 生徒用ダッシュボード
├── Courses/
│   ├── Index.jsx        # コース一覧
│   ├── Show.jsx         # コース詳細
│   ├── New.jsx          # コース作成
│   └── Edit.jsx         # コース編集
├── Auth/
│   ├── Login.jsx        # ログインページ
│   └── Register.jsx     # 登録ページ
└── Layouts/
    └── AppLayout.jsx    # 共通レイアウト
```

### 3.2 共通レイアウトの作成

まず、全ページで使用する共通レイアウトを作成します。

**ファイル: `app/javascript/Pages/Layouts/AppLayout.jsx`**

```jsx
import React from 'react'
import { Link } from '@inertiajs/react'

export default function AppLayout({ children, user }) {
  return (
    <div className="min-h-screen bg-gray-50">
      {/* ナビゲーションバー */}
      <nav className="bg-white shadow-sm">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between h-16">
            <div className="flex items-center">
              <Link href="/" className="text-xl font-bold text-indigo-600">
                教育プラットフォーム
              </Link>
              <div className="ml-10 flex space-x-4">
                <Link
                  href="/dashboard"
                  className="text-gray-700 hover:text-indigo-600 px-3 py-2"
                >
                  ダッシュボード
                </Link>
                <Link
                  href="/courses"
                  className="text-gray-700 hover:text-indigo-600 px-3 py-2"
                >
                  コース
                </Link>
              </div>
            </div>
            <div className="flex items-center space-x-4">
              {user ? (
                <>
                  <span className="text-gray-700">{user.name}</span>
                  <Link
                    href="/users/sign_out"
                    method="delete"
                    as="button"
                    className="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600"
                  >
                    ログアウト
                  </Link>
                </>
              ) : (
                <Link
                  href="/users/sign_in"
                  className="bg-indigo-600 text-white px-4 py-2 rounded hover:bg-indigo-700"
                >
                  ログイン
                </Link>
              )}
            </div>
          </div>
        </div>
      </nav>

      {/* メインコンテンツ */}
      <main className="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
        {children}
      </main>
    </div>
  )
}
```

### 3.3 教師用ダッシュボード

**ファイル: `app/javascript/Pages/Dashboard/Teacher.jsx`**

```jsx
import React from 'react'
import AppLayout from '../Layouts/AppLayout'

export default function TeacherDashboard({ courses, unanswered_questions, user }) {
  return (
    <AppLayout user={user}>
      <div className="px-4 py-6 sm:px-0">
        <h1 className="text-3xl font-bold text-gray-900 mb-6">
          教師ダッシュボード
        </h1>

        {/* コース一覧 */}
        <div className="bg-white rounded-lg shadow p-6 mb-6">
          <h2 className="text-xl font-semibold mb-4">担当コース</h2>
          {courses.length > 0 ? (
            <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
              {courses.map((course) => (
                <div
                  key={course.id}
                  className="border rounded-lg p-4 hover:shadow-md transition"
                >
                  <h3 className="font-semibold text-lg mb-2">{course.title}</h3>
                  <p className="text-gray-600 text-sm mb-3">
                    {course.description?.substring(0, 100)}...
                  </p>
                  <div className="flex justify-between items-center">
                    <span className="text-sm text-gray-500">
                      {course.lessons?.length || 0} レッスン
                    </span>
                    <a
                      href={`/courses/${course.id}`}
                      className="text-indigo-600 hover:text-indigo-800 text-sm"
                    >
                      詳細 →
                    </a>
                  </div>
                </div>
              ))}
            </div>
          ) : (
            <p className="text-gray-500">コースがまだありません。</p>
          )}
        </div>

        {/* 未回答の質問 */}
        <div className="bg-white rounded-lg shadow p-6">
          <h2 className="text-xl font-semibold mb-4">生徒からの質問</h2>
          {unanswered_questions.length > 0 ? (
            <div className="space-y-4">
              {unanswered_questions.map((question) => (
                <div
                  key={question.id}
                  className="border-l-4 border-yellow-400 pl-4 py-2"
                >
                  <div className="flex justify-between items-start">
                    <div>
                      <p className="font-medium">{question.student.name}</p>
                      <p className="text-sm text-gray-600">
                        {question.lesson.course.title} - {question.lesson.title}
                      </p>
                      <p className="mt-2 text-gray-800">{question.question}</p>
                    </div>
                    <button className="text-indigo-600 hover:text-indigo-800 text-sm">
                      回答する
                    </button>
                  </div>
                </div>
              ))}
            </div>
          ) : (
            <p className="text-gray-500">未回答の質問はありません。</p>
          )}
        </div>
      </div>
    </AppLayout>
  )
}
```

### 3.4 生徒用ダッシュボード

**ファイル: `app/javascript/Pages/Dashboard/Student.jsx`**

```jsx
import React from 'react'
import AppLayout from '../Layouts/AppLayout'

export default function StudentDashboard({
  today_plans,
  recent_records,
  upcoming_plans,
  my_questions,
  user,
}) {
  return (
    <AppLayout user={user}>
      <div className="px-4 py-6 sm:px-0">
        <h1 className="text-3xl font-bold text-gray-900 mb-6">
          学習ダッシュボード
        </h1>

        {/* 今日の学習計画 */}
        <div className="bg-white rounded-lg shadow p-6 mb-6">
          <h2 className="text-xl font-semibold mb-4">今日の学習</h2>
          {today_plans.length > 0 ? (
            <div className="space-y-3">
              {today_plans.map((plan) => (
                <div
                  key={plan.id}
                  className="flex items-center justify-between p-4 bg-blue-50 rounded-lg"
                >
                  <div>
                    <p className="font-medium">{plan.lesson.course.title}</p>
                    <p className="text-sm text-gray-600">{plan.lesson.title}</p>
                  </div>
                  <button className="bg-indigo-600 text-white px-4 py-2 rounded hover:bg-indigo-700">
                    開始
                  </button>
                </div>
              ))}
            </div>
          ) : (
            <p className="text-gray-500">今日の予定はありません。</p>
          )}
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {/* 最近の学習記録 */}
          <div className="bg-white rounded-lg shadow p-6">
            <h2 className="text-xl font-semibold mb-4">最近の学習</h2>
            {recent_records.length > 0 ? (
              <div className="space-y-3">
                {recent_records.map((record) => (
                  <div key={record.id} className="border-b pb-3">
                    <p className="font-medium">{record.lesson.course.title}</p>
                    <p className="text-sm text-gray-600">{record.lesson.title}</p>
                    <div className="flex justify-between mt-2 text-sm">
                      <span className="text-gray-500">{record.duration}分</span>
                      <span
                        className={
                          record.completed ? 'text-green-600' : 'text-yellow-600'
                        }
                      >
                        {record.completed ? '完了' : '進行中'}
                      </span>
                    </div>
                  </div>
                ))}
              </div>
            ) : (
              <p className="text-gray-500">学習記録がありません。</p>
            )}
          </div>

          {/* 今後の予定 */}
          <div className="bg-white rounded-lg shadow p-6">
            <h2 className="text-xl font-semibold mb-4">今後の予定</h2>
            {upcoming_plans.length > 0 ? (
              <div className="space-y-3">
                {upcoming_plans.slice(0, 5).map((plan) => (
                  <div key={plan.id} className="border-b pb-3">
                    <p className="font-medium">{plan.lesson.course.title}</p>
                    <p className="text-sm text-gray-600">{plan.lesson.title}</p>
                    <p className="text-xs text-gray-500 mt-1">
                      {new Date(plan.scheduled_at).toLocaleDateString('ja-JP')}
                    </p>
                  </div>
                ))}
              </div>
            ) : (
              <p className="text-gray-500">予定はありません。</p>
            )}
          </div>
        </div>

        {/* 私の質問 */}
        {my_questions.length > 0 && (
          <div className="bg-white rounded-lg shadow p-6 mt-6">
            <h2 className="text-xl font-semibold mb-4">私の質問</h2>
            <div className="space-y-3">
              {my_questions.map((question) => (
                <div key={question.id} className="border-l-4 border-blue-400 pl-4 py-2">
                  <p className="text-sm text-gray-600">{question.lesson.title}</p>
                  <p className="mt-1">{question.question}</p>
                  <p className="text-xs text-gray-500 mt-2">
                    {question.answered_at ? '回答済み' : '未回答'}
                  </p>
                </div>
              ))}
            </div>
          </div>
        )}
      </div>
    </AppLayout>
  )
}
```

### 3.5 コース一覧ページ

**ファイル: `app/javascript/Pages/Courses/Index.jsx`**

```jsx
import React from 'react'
import { Link } from '@inertiajs/react'
import AppLayout from '../Layouts/AppLayout'

export default function CoursesIndex({ courses, user }) {
  return (
    <AppLayout user={user}>
      <div className="px-4 py-6 sm:px-0">
        <div className="flex justify-between items-center mb-6">
          <h1 className="text-3xl font-bold text-gray-900">コース一覧</h1>
          {user?.role === 'teacher' && (
            <Link
              href="/courses/new"
              className="bg-indigo-600 text-white px-4 py-2 rounded hover:bg-indigo-700"
            >
              新規作成
            </Link>
          )}
        </div>

        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {courses.map((course) => (
            <div
              key={course.id}
              className="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-lg transition"
            >
              <div className="p-6">
                <h2 className="text-xl font-semibold mb-2">{course.title}</h2>
                <p className="text-gray-600 mb-4">
                  {course.description?.substring(0, 150)}...
                </p>
                <div className="flex justify-between items-center">
                  <span className="text-sm text-gray-500">
                    担当: {course.teacher.name}
                  </span>
                  <Link
                    href={`/courses/${course.id}`}
                    className="text-indigo-600 hover:text-indigo-800 font-medium"
                  >
                    詳細 →
                  </Link>
                </div>
              </div>
            </div>
          ))}
        </div>

        {courses.length === 0 && (
          <div className="text-center py-12">
            <p className="text-gray-500 text-lg">コースがまだありません。</p>
          </div>
        )}
      </div>
    </AppLayout>
  )
}
```

### 3.6 コンポーネント作成の手順

1. **ディレクトリ作成**
   ```bash
   mkdir -p app/javascript/Pages/Dashboard
   mkdir -p app/javascript/Pages/Courses
   mkdir -p app/javascript/Pages/Layouts
   mkdir -p app/javascript/Pages/Auth
   ```

2. **コンポーネントファイルの作成**
   - 上記のコード例を参考に各ファイルを作成

3. **アセットのビルド**
   ```bash
   yarn build
   yarn build:css
   ```

4. **開発サーバーの起動**
   ```bash
   bin/dev
   ```

---

## ステップ4: 認証の統合

### 4.1 Deviseビューのカスタマイズ

Deviseのビューを生成して、Inertia.js対応にします。

```bash
rails generate devise:views
```

### 4.2 カスタム認証コントローラーの作成

**ファイル: `app/controllers/users/sessions_controller.rb`**

```ruby
# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # GET /users/sign_in
  def new
    render inertia: 'Auth/Login'
  end

  # POST /users/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)

    redirect_to after_sign_in_path_for(resource)
  end

  # DELETE /users/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out

    redirect_to after_sign_out_path_for(resource_name)
  end

  protected

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
```

### 4.3 ルーティングの更新

**ファイル: `config/routes.rb`**

```ruby
Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # 認証が必要なルート
  authenticate :user do
    get "dashboard", to: "dashboard#index", as: :dashboard
    get "dashboard/teacher", to: "dashboard#teacher_dashboard", as: :teacher_dashboard
    get "dashboard/student", to: "dashboard#student_dashboard", as: :student_dashboard

    resources :courses
  end

  # 公開ルート
  root "home#index"
  get "up" => "rails/health#show", as: :rails_health_check
end
```

### 4.4 ログインページの作成

**ファイル: `app/javascript/Pages/Auth/Login.jsx`**

```jsx
import React, { useState } from 'react'
import { useForm } from '@inertiajs/react'

export default function Login() {
  const { data, setData, post, processing, errors } = useForm({
    email: '',
    password: '',
    remember_me: false,
  })

  const handleSubmit = (e) => {
    e.preventDefault()
    post('/users/sign_in')
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-50 py-12 px-4 sm:px-6 lg:px-8">
      <div className="max-w-md w-full space-y-8">
        <div>
          <h2 className="mt-6 text-center text-3xl font-extrabold text-gray-900">
            ログイン
          </h2>
          <p className="mt-2 text-center text-sm text-gray-600">
            教育プラットフォームへようこそ
          </p>
        </div>

        <form className="mt-8 space-y-6" onSubmit={handleSubmit}>
          <div className="rounded-md shadow-sm -space-y-px">
            <div>
              <label htmlFor="email" className="sr-only">
                メールアドレス
              </label>
              <input
                id="email"
                name="email"
                type="email"
                required
                className="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-t-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm"
                placeholder="メールアドレス"
                value={data.email}
                onChange={(e) => setData('email', e.target.value)}
              />
              {errors.email && (
                <p className="text-red-500 text-xs mt-1">{errors.email}</p>
              )}
            </div>
            <div>
              <label htmlFor="password" className="sr-only">
                パスワード
              </label>
              <input
                id="password"
                name="password"
                type="password"
                required
                className="appearance-none rounded-none relative block w-full px-3 py-2 border border-gray-300 placeholder-gray-500 text-gray-900 rounded-b-md focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 focus:z-10 sm:text-sm"
                placeholder="パスワード"
                value={data.password}
                onChange={(e) => setData('password', e.target.value)}
              />
              {errors.password && (
                <p className="text-red-500 text-xs mt-1">{errors.password}</p>
              )}
            </div>
          </div>

          <div className="flex items-center justify-between">
            <div className="flex items-center">
              <input
                id="remember_me"
                name="remember_me"
                type="checkbox"
                className="h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300 rounded"
                checked={data.remember_me}
                onChange={(e) => setData('remember_me', e.target.checked)}
              />
              <label
                htmlFor="remember_me"
                className="ml-2 block text-sm text-gray-900"
              >
                ログイン状態を保持
              </label>
            </div>
          </div>

          <div>
            <button
              type="submit"
              disabled={processing}
              className="group relative w-full flex justify-center py-2 px-4 border border-transparent text-sm font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 disabled:opacity-50"
            >
              {processing ? 'ログイン中...' : 'ログイン'}
            </button>
          </div>

          <div className="text-center">
            <p className="text-sm text-gray-600">
              テストアカウント: admin@example.com / password123
            </p>
          </div>
        </form>
      </div>
    </div>
  )
}
```

### 4.5 ApplicationControllerの更新

**ファイル: `app/controllers/application_controller.rb`**

```ruby
class ApplicationController < ActionController::Base
  include InertiaCsrf

  # Inertiaでflashメッセージを共有
  inertia_share flash: -> { flash.to_hash }

  # 現在のユーザー情報を全てのInertiaページで共有
  inertia_share do
    if user_signed_in?
      {
        auth: {
          user: current_user.as_json(only: [:id, :name, :email, :role])
        }
      }
    else
      {
        auth: {
          user: nil
        }
      }
    end
  end

  # ログインが必要なアクションの前に実行
  before_action :authenticate_user!, unless: :devise_controller?

  # Only allow modern browsers
  allow_browser versions: :modern
end
```

---

## ステップ5: Active Storageの設定

### 5.1 Active Storageのインストール

```bash
rails active_storage:install
rails db:migrate
```

### 5.2 ストレージ設定

**ファイル: `config/storage.yml`** (既に存在)

開発環境ではローカルストレージを使用する設定になっています：

```yaml
local:
  service: Disk
  root: <%= Rails.root.join("storage") %>
```

### 5.3 環境別設定

**ファイル: `config/environments/development.rb`**

```ruby
# Active Storageの設定を追加
config.active_storage.service = :local
```

### 5.4 ファイルアップロードフォームの例

**教材アップロード用コンポーネント例:**

```jsx
import React, { useState } from 'react'
import { useForm } from '@inertiajs/react'

export default function MaterialForm({ lesson }) {
  const { data, setData, post, processing, errors } = useForm({
    title: '',
    description: '',
    material_type: 'text',
    file: null,
  })

  const handleSubmit = (e) => {
    e.preventDefault()
    post(`/lessons/${lesson.id}/materials`)
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-4">
      <div>
        <label className="block text-sm font-medium text-gray-700">
          タイトル
        </label>
        <input
          type="text"
          value={data.title}
          onChange={(e) => setData('title', e.target.value)}
          className="mt-1 block w-full rounded-md border-gray-300 shadow-sm"
        />
      </div>

      <div>
        <label className="block text-sm font-medium text-gray-700">
          種類
        </label>
        <select
          value={data.material_type}
          onChange={(e) => setData('material_type', e.target.value)}
          className="mt-1 block w-full rounded-md border-gray-300 shadow-sm"
        >
          <option value="text">テキスト</option>
          <option value="image">画像</option>
          <option value="pdf">PDF</option>
          <option value="link">リンク</option>
        </select>
      </div>

      <div>
        <label className="block text-sm font-medium text-gray-700">
          ファイル
        </label>
        <input
          type="file"
          onChange={(e) => setData('file', e.target.files[0])}
          className="mt-1 block w-full"
        />
      </div>

      <button
        type="submit"
        disabled={processing}
        className="bg-indigo-600 text-white px-4 py-2 rounded hover:bg-indigo-700"
      >
        アップロード
      </button>
    </form>
  )
}
```

### 5.5 コントローラーでのファイル処理

**MaterialsControllerの例:**

```ruby
class MaterialsController < ApplicationController
  def create
    @material = Material.new(material_params)
    @material.lesson_id = params[:lesson_id]

    if @material.save
      # ファイルが添付されている場合
      if params[:material][:file].present?
        @material.file.attach(params[:material][:file])
      end

      redirect_to lesson_path(@material.lesson), notice: '教材を追加しました。'
    else
      render inertia: 'Materials/New', props: {
        material: @material,
        errors: @material.errors.full_messages
      }
    end
  end

  private

  def material_params
    params.require(:material).permit(:title, :description, :material_type)
  end
end
```

---

## 追加の機能実装

### レッスン管理

**LessonsControllerの作成:**

```bash
rails generate controller Lessons index show new create edit update destroy --skip-routes
```

**ルーティング追加:**

```ruby
resources :courses do
  resources :lessons
end
```

### 学習記録機能

**LearningRecordsControllerの作成:**

```bash
rails generate controller LearningRecords create update
```

### テスト受験機能

**QuestionsControllerとTestResultsControllerの作成が必要**

---

## トラブルシューティング

### よくある問題と解決方法

#### 1. Inertia.jsでコンポーネントが見つからない

**エラー:** `Inertia page component not found`

**解決方法:**
- ファイルパスが正しいか確認
- ファイル名の大文字小文字を確認
- `yarn build` を実行してアセットを再ビルド

#### 2. CSRF token error

**解決方法:**
- ApplicationControllerに `include InertiaCsrf` が含まれているか確認
- レイアウトに `<%= csrf_meta_tags %>` があるか確認

#### 3. Active Storageでファイルがアップロードできない

**解決方法:**
- マイグレーションが実行されているか確認: `rails db:migrate:status`
- storage ディレクトリのパーミッションを確認
- フォームで `enctype="multipart/form-data"` が設定されているか確認

#### 4. SQLiteのdate型エラー

DashboardControllerの以下の行でエラーが出る場合：

```ruby
.where("scheduled_at::date = ?", Date.today)
```

SQLite用に修正：

```ruby
.where("date(scheduled_at) = ?", Date.today)
```

---

## 開発の流れ

### 推奨される実装順序

1. ✅ データベース・モデル（完了）
2. ✅ コントローラー基礎（完了）
3. 🔄 Reactコンポーネント（次）
   - レイアウト作成
   - ダッシュボード作成
   - コース管理UI作成
4. 🔄 認証統合
   - ログインページ
   - 認証フロー
5. 🔄 Active Storage
   - ファイルアップロード
   - 画像・動画表示
6. ⏳ 追加機能
   - レッスン詳細
   - 学習記録
   - テスト受験
   - 質問投稿

---

## テストアカウント

開発・テスト用のアカウント情報:

```
管理者:
  Email: admin@example.com
  Password: password123

教師1:
  Email: tanaka@example.com
  Password: password123

教師2:
  Email: hanako@example.com
  Password: password123

生徒1:
  Email: ichiro@example.com
  Password: password123

生徒2:
  Email: jiro@example.com
  Password: password123
```

---

## 参考リンク

- [Inertia.js公式ドキュメント](https://inertiajs.com/)
- [React公式ドキュメント](https://react.dev/)
- [Tailwind CSS公式ドキュメント](https://tailwindcss.com/)
- [Devise Wiki](https://github.com/heartcombo/devise/wiki)
- [Active Storage Guide](https://guides.rubyonrails.org/active_storage_overview.html)

---

## まとめ

このドキュメントに従って実装を進めることで、完全に動作する教育向けプラットフォームを構築できます。

**次の作業開始時:**

1. このドキュメントを読む
2. ステップ3から順番に実装
3. 各ステップでテストを実行
4. 問題が発生したらトラブルシューティングを参照

質問や問題がある場合は、エラーメッセージとともに確認してください。

Happy Coding! 🚀
