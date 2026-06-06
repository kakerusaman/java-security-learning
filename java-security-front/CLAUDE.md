# ECサイト — AI開発設計書

## プロジェクト概要

React + TypeScript 製の ECサイト。
商品一覧・商品詳細・カート・購入フロー・ユーザー認証を含む。

---

## 技術スタック

| 種別 | ライブラリ | バージョン |
|------|-----------|-----------|
| フレームワーク | React | 18.x |
| 言語 | TypeScript | 5.x |
| 状態管理 | Zustand | 4.x |
| スタイリング | Tailwind CSS | 3.x |
| APIクライアント | Axios | 1.x |
| ルーティング | React Router | 6.x |
| フォーム | React Hook Form + Zod | latest |
| テスト | Vitest + Testing Library | latest |

---

## ディレクトリ構成

```
src/
├── components/        # 共通UIパーツ（Button, Input, Modal等）
├── features/          # 機能単位のコンポーネント・ロジック
│   ├── auth/          # ログイン・会員登録
│   ├── cart/          # カート
│   └── product/       # 商品一覧・詳細
├── hooks/             # カスタムフック（useCart, useAuth等）
├── stores/            # Zustand store
├── types/             # 型定義（index.ts からre-export）
├── lib/               # Axiosインスタンス・ユーティリティ
└── pages/             # ページコンポーネント（ルーティング対応）
```

---

## コーディングルール

### 全般
- コンポーネントは**アロー関数**で書く（function宣言禁止）
- `any` 型は**使用禁止**。型が不明な場合は `unknown` を使う
- `export default` はページコンポーネントのみ。それ以外は**named export**
- コメントは日本語でOK

### 型定義
- props の型は **interface** で定義する（type alias不可）
- 型定義ファイルは `src/types/` に配置し、`src/types/index.ts` からre-exportする
- APIレスポンスの型は必ず定義する

### コンポーネント
- 1ファイル1コンポーネントを原則とする
- 共通UIパーツは `src/components/` に置く
- 機能に紐づくコンポーネントは `src/features/<機能名>/` に置く
- スタイルは **Tailwind CSS** のユーティリティクラスのみ使用（インラインstyle禁止）

### 状態管理
- グローバル状態は **Zustand** を使う
- サーバーから取得するデータは **Axios + カスタムフック** で管理する
- ローカルなUI状態（モーダル開閉等）は `useState` でよい

### APIクライアント
- Axiosインスタンスは `src/lib/axios.ts` の `apiClient` を必ず使う
- API呼び出しは `src/features/<機能名>/api.ts` にまとめる
- エラーハンドリングは必ず行う（try/catch または .catch）

### Zustand Store
- storeファイルは `src/stores/<機能名>Store.ts` に配置する
- storeのinterfaceは `State` と `Actions` を分けて定義する

---

## 命名規則

| 種別 | 規則 | 例 |
|------|------|----|
| コンポーネントファイル | PascalCase | `ProductCard.tsx` |
| フックファイル | camelCase（use〜） | `useCart.ts` |
| storeファイル | camelCase（〜Store） | `cartStore.ts` |
| 型定義ファイル | camelCase | `product.ts` |
| APIファイル | camelCase | `productApi.ts` |
| CSSクラス | Tailwindのみ | — |

---

## 指示のフォーマット（AI駆動開発用）

新しいコンポーネントやファイルを作成する際は、以下のフォーマットで指示する：

```
【対象ファイル】src/features/cart/CartItem.tsx
【使用する型】src/types/index.ts の CartItem
【やること】数量変更（+/-ボタン）と削除ボタンを実装
【制約】在庫数（stock）を超える数量にはできないようにする
```

---

## スラッシュコマンド一覧

| コマンド | 用途 |
|----------|------|
| `/new-component <名前>` | 共通UIコンポーネントを新規作成 |
| `/new-feature <機能名> <コンポーネント名>` | featuresコンポーネントを新規作成 |
| `/new-store <機能名>` | Zustand storeを新規作成 |
| `/new-api <機能名>` | API関数ファイルを新規作成 |
