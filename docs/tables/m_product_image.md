# テーブル設計書：m_product_image

## 基本情報

| 項目 | 内容 |
|------|------|
| テーブル名 | `m_product_image` |
| 種別 | マスター系 |
| 説明 | 商品に紐づく画像URLを管理する。1商品につき複数画像に対応し、メイン画像フラグで主画像を識別する。 |
| DB | PostgreSQL |
| 作成日 | 2026-06-09 |

---

## カラム定義

| # | カラム名 | 型 | 制約 | デフォルト値 | 説明 |
|---|----------|----|------|-------------|------|
| 1 | `image_id` | `BIGSERIAL` | PK | - | 主キー |
| 2 | `product_id` | `BIGINT` | NN, FK | - | 商品ID |
| 3 | `image_url` | `VARCHAR(512)` | NN | - | 画像URL（S3など） |
| 4 | `is_main` | `BOOLEAN` | NN, DF | FALSE | メイン画像フラグ |
| 5 | `sort_order` | `INTEGER` | NN, DF | 0 | 表示順 |
| 6 | `created_at` | `TIMESTAMPTZ` | NN, DF | CURRENT_TIMESTAMP | レコード作成日時 |
| 7 | `updated_at` | `TIMESTAMPTZ` | NN, DF | CURRENT_TIMESTAMP | レコード更新日時 |

---

## 制約詳細

### 主キー
- `image_id`

### 外部キー
| カラム名 | 参照テーブル | 参照カラム |
|----------|------------|-----------|
| `product_id` | `m_product` | `product_id` |

### 部分ユニーク制約（インデックス）
| インデックス名 | 条件 | 目的 |
|--------------|------|------|
| `uix_m_product_image_main` | `is_main = TRUE` | 1商品につきメイン画像を1件のみに限定 |

---

## DDL

```sql
CREATE TABLE m_product_image (
    image_id     BIGSERIAL       NOT NULL,
    product_id   BIGINT          NOT NULL
                     REFERENCES m_product(product_id),
    image_url    VARCHAR(512)    NOT NULL,
    is_main      BOOLEAN         NOT NULL DEFAULT FALSE,
    sort_order   INTEGER         NOT NULL DEFAULT 0,
    created_at   TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_m_product_image PRIMARY KEY (image_id)
);

-- 1商品につきメイン画像は1件のみ許可する部分ユニークインデックス
CREATE UNIQUE INDEX uix_m_product_image_main
    ON m_product_image (product_id)
    WHERE is_main = TRUE;

COMMENT ON TABLE m_product_image IS '商品画像マスタ';
COMMENT ON COLUMN m_product_image.image_id IS '主キー';
COMMENT ON COLUMN m_product_image.product_id IS '商品ID（m_product参照）';
COMMENT ON COLUMN m_product_image.image_url IS '画像URL（S3など外部ストレージのURL）';
COMMENT ON COLUMN m_product_image.is_main IS 'メイン画像フラグ（TRUEは1商品1件のみ）';
COMMENT ON COLUMN m_product_image.sort_order IS '表示順';
COMMENT ON COLUMN m_product_image.created_at IS 'レコード作成日時';
COMMENT ON COLUMN m_product_image.updated_at IS 'レコード更新日時';
```

---

## 備考

- `is_main = TRUE` のレコードは部分ユニークインデックスにより1商品につき1件に制限される
- `updated_at` の自動更新はアプリケーション側またはトリガーで対応すること
