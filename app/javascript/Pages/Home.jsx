import React from 'react'

export default function Home() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-50 to-indigo-100">
      <div className="container mx-auto px-4 py-16">
        <div className="max-w-4xl mx-auto text-center">
          <h1 className="text-5xl font-bold text-gray-900 mb-6">
            教育向けプラットフォーム
          </h1>
          <p className="text-xl text-gray-700 mb-8">
            Rails 8 + Inertia.js + React + Tailwind CSS
          </p>

          <div className="bg-white rounded-lg shadow-xl p-8 mb-8">
            <h2 className="text-2xl font-semibold text-gray-800 mb-4">
              プラットフォームの特徴
            </h2>
            <div className="grid md:grid-cols-2 gap-6 text-left">
              <div className="p-4 bg-blue-50 rounded-lg">
                <h3 className="font-bold text-lg text-blue-900 mb-2">教師向け機能</h3>
                <ul className="text-gray-700 space-y-1">
                  <li>・教材管理</li>
                  <li>・テスト問題管理</li>
                  <li>・レッスン動画管理</li>
                  <li>・コース管理</li>
                </ul>
              </div>

              <div className="p-4 bg-green-50 rounded-lg">
                <h3 className="font-bold text-lg text-green-900 mb-2">生徒向け機能</h3>
                <ul className="text-gray-700 space-y-1">
                  <li>・学習記録管理</li>
                  <li>・学習メモ管理</li>
                  <li>・テスト結果記録</li>
                  <li>・質問投稿機能</li>
                  <li>・学習計画機能</li>
                </ul>
              </div>
            </div>
          </div>

          <div className="bg-gradient-to-r from-indigo-500 to-purple-600 text-white rounded-lg p-6">
            <p className="text-lg font-medium">
              アクティブラーニングと分散学習を活用した家庭内学習プラットフォーム
            </p>
          </div>
        </div>
      </div>
    </div>
  )
}
