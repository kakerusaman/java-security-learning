# テーブル設計書：m_genre

## 基本情報

| 項目 | 内容 |
|------|------|
| テーブル名 | `m_genre` |
| 種別 | マスター系 |
| 説明 | 商品のジャンル（カテゴリ）を管理する。親ジャンルを持つことで階層構造に対応。 |
| DB | PostgreSQL |
| 作成日 | 2026-06-09 |

---

## カラム定義

| # | カラム名 | 型 | 制約 | デフォルト値 | 説明 |
|---|----------|----|------|-------------|------|
| 1 | `genre_id` | `BIGSERIAL` | PK | - | 主キー |
| 2 | `genre_name` | `VARCHAR(100)` | NN | - | ジャンル名 |
| 3 | `parent_genre_id` | `BIGINT` | FK | NULL | 親ジャンルID（NULLの場合はルート）|
| 4 | `created_at` | `TIMESTAMPTZ` | NN, DF | CURRENT_TIMESTAMP | レコード作成日時 |
| 5 | `updated_at` | `TIMESTAMPTZ` | NN, DF | CURRENT_TIMESTAMP | レコード更新日時 |

---

## 制約詳細

### 主キー
- `genre_id`

### 外部キー
| カラム名 | 参照テーブル | 参照カラム |
|----------|------------|-----------|
| `parent_genre_id` | `m_genre` | `genre_id` |

---

## DDL

```sql
CREATE TABLE m_genre (
    genre_id         BIGSERIAL       NOT NULL,
    genre_name       VARCHAR(100)    NOT NULL,
    parent_genre_id  BIGINT          NULL
                         REFERENCES m_genre(genre_id),
    created_at       TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_m_genre PRIMARY KEY (genre_id)
);

COMMENT ON TABLE m_genre IS '商品ジャンルマスタ';
COMMENT ON COLUMN m_genre.genre_id IS '主キー';
COMMENT ON COLUMN m_genre.genre_name IS 'ジャンル名';
COMMENT ON COLUMN m_genre.parent_genre_id IS '親ジャンルID（NULLはルートジャンル）';
COMMENT ON COLUMN m_genre.created_at IS 'レコード作成日時';
COMMENT ON COLUMN m_genre.updated_at IS 'レコード更新日時';
```

---

## 備考

- 自己参照外部キーにより階層構造（大ジャンル > 中ジャンル > 小ジャンル）を表現できる
- `updated_at` の自動更新はアプリケーション側またはトリガーで対応すること
