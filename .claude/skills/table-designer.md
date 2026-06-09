---
name: table-designer
description: >
  PostgreSQLのテーブル設計書をMarkdown形式で作成するスキル。
  テーブル名・カラム名・型・制約・説明を含む設計書を docs/tables/ 配下に出力する。
  テーブル名はトランザクション系は t_、マスター系は m_ プレフィックスを付ける。
  「テーブル設計書を作りたい」「テーブルを定義したい」「DB設計をしたい」「カラムを決めたい」
  といったフレーズが出た際はこのスキルを使うこと。
  Claude Codeでの使用を前提とする。
---

# Table Designer — PostgreSQL テーブル設計書作成スキル

テーブル定義をヒアリングし、Markdown形式の設計書を `docs/tables/` 配下に出力する。

---

## テーブル命名規則

| 種別 | プレフィックス | 例 |
|------|--------------|-----|
| トランザクション系（注文・履歴・ログ等） | `t_` | `t_order`, `t_login_history` |
| マスター系（ユーザー・商品・コード等） | `m_` | `m_user`, `m_product`, `m_code` |

**判断基準：**
- トランザクション系：業務処理の結果として生成・更新されるデータ（注文、支払い、ログ、履歴など）
- マスター系：システムで管理する基本データ（ユーザー、商品、区分値、設定など）

---

## カラム型一覧（PostgreSQL）

| 用途 | 推奨型 |
|------|--------|
| 主キー（自動採番） | `BIGSERIAL` または `SERIAL` |
| 主キー（UUID） | `UUID` |
| 短い文字列（固定長） | `CHAR(n)` |
| 短い文字列（可変長） | `VARCHAR(n)` |
| 長いテキスト | `TEXT` |
| 整数 | `INTEGER` / `BIGINT` |
| 小数 | `NUMERIC(p, s)` |
| 真偽値 | `BOOLEAN` |
| 日付のみ | `DATE` |
| 日時 | `TIMESTAMP` |
| タイムゾーン付き日時 | `TIMESTAMPTZ` |
| JSON | `JSONB` |

---

## 制約一覧

| 記号 | 制約 | 説明 |
|------|------|------|
| `PK` | PRIMARY KEY | 主キー |
| `FK` | FOREIGN KEY | 外部キー |
| `NN` | NOT NULL | NULL不可 |
| `UQ` | UNIQUE | 一意制約 |
| `DF` | DEFAULT | デフォルト値あり |
| `CK` | CHECK | チェック制約 |

---

## ワークフロー

### Step 1: テーブル情報のヒアリング

ユーザーにテーブルの用途を確認し、以下を決定する：

1. テーブルの目的・用途（何のデータを管理するか）
2. 種別の判定 → `t_` or `m_` プレフィックスを決定
3. テーブル名（英小文字・スネークケース）
4. 各カラムの情報：
   - カラム名（英小文字・スネークケース）
   - 型
   - 制約（PK / FK / NN / UQ / DF / CK）
   - 説明（日本語）

---

### Step 2: 共通カラムの自動付与

以下の共通カラムは**全テーブルに自動で付与**する（ユーザーへの確認不要）：

| カラム名 | 型 | 制約 | 説明 |
|----------|-----|------|------|
| `created_at` | `TIMESTAMPTZ` | NN, DF | レコード作成日時（DEFAULT CURRENT_TIMESTAMP） |
| `updated_at` | `TIMESTAMPTZ` | NN, DF | レコード更新日時（DEFAULT CURRENT_TIMESTAMP） |

---

### Step 3: 設計書ファイルの生成

```bash
mkdir -p docs/tables
```

ファイル名: `docs/tables/{テーブル名}.md`

---

## 設計書テンプレート

```markdown
# テーブル設計書：{テーブル名}

## 基本情報

| 項目 | 内容 |
|------|------|
| テーブル名 | `{テーブル名}` |
| 種別 | トランザクション系 / マスター系 |
| 説明 | {テーブルの用途・目的} |
| DB | PostgreSQL |
| 作成日 | YYYY-MM-DD |

---

## カラム定義

| # | カラム名 | 型 | 制約 | デフォルト値 | 説明 |
|---|----------|----|------|-------------|------|
| 1 | `id` | `BIGSERIAL` | PK | - | 主キー |
| 2 | `{カラム名}` | `{型}` | {制約} | {デフォルト値 or -} | {説明} |
| N | `created_at` | `TIMESTAMPTZ` | NN, DF | CURRENT_TIMESTAMP | レコード作成日時 |
| N | `updated_at` | `TIMESTAMPTZ` | NN, DF | CURRENT_TIMESTAMP | レコード更新日時 |

---

## 制約詳細

### 主キー
- `id`

### 外部キー
| カラム名 | 参照テーブル | 参照カラム |
|----------|------------|-----------|
| `{fk_column}` | `{参照テーブル名}` | `{参照カラム名}` |

### ユニーク制約
- `{カラム名}`

### チェック制約
| 制約名 | 条件 |
|--------|------|
| `{制約名}` | `{条件式}` |

---

## DDL

​```sql
CREATE TABLE {テーブル名} (
    id          BIGSERIAL       NOT NULL,
    {カラム名}   {型}            {NOT NULL / NULL},
    created_at  TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_{テーブル名} PRIMARY KEY (id)
);

-- コメント
COMMENT ON TABLE {テーブル名} IS '{テーブルの説明}';
COMMENT ON COLUMN {テーブル名}.{カラム名} IS '{カラムの説明}';
​```

---

## 備考

- {特記事項があれば記載}
```

---

## Claude Codeでの登録方法

`.claude/commands/table-design.md` を作成：

```markdown
table-designerスキルの手順に従い、テーブル設計書を作成してください。
対象テーブル: $ARGUMENTS（未指定の場合はヒアリングから開始）

docs/tables/{テーブル名}.md を生成してください。
テーブル名はトランザクション系なら t_、マスター系なら m_ プレフィックスを付けること。
共通カラム（created_at, updated_at）は自動付与すること。
```

使用時：
```
/table-design
/table-design ユーザーテーブル
```

---

## 注意事項

- テーブル名・カラム名は**英小文字・スネークケース**に統一する
- 主キーは原則 `id`（BIGSERIAL）を使用する。UUIDが必要な場合はユーザーに確認する
- 外部キーのカラム名は `{参照テーブル名（プレフィックス除去）}_id` の形式を推奨（例: `m_user` → `user_id`）
- `updated_at` の自動更新はアプリケーション側またはトリガーで対応する旨を備考に記載する
- 論理削除が必要かユーザーに確認し、必要であれば `deleted_at TIMESTAMPTZ` カラムを追加する
