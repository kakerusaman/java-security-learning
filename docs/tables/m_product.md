# テーブル設計書：m_product

## 基本情報

| 項目 | 内容 |
|------|------|
| テーブル名 | `m_product` |
| 種別 | マスター系 |
| 説明 | 商品の基本情報（名称・価格・在庫・公開状態など）を管理するメインテーブル。 |
| DB | PostgreSQL |
| 作成日 | 2026-06-09 |

---

## カラム定義

| # | カラム名 | 型 | 制約 | デフォルト値 | 説明 |
|---|----------|----|------|-------------|------|
| 1 | `product_id` | `BIGSERIAL` | PK | - | 主キー |
| 2 | `product_code` | `VARCHAR(50)` | NN, UQ | - | 商品番号（SKUコードなど） |
| 3 | `product_name` | `VARCHAR(255)` | NN | - | 商品名 |
| 4 | `description` | `TEXT` | - | NULL | 商品説明 |
| 5 | `price` | `NUMERIC(10, 2)` | NN, CK | - | 販売価格（税抜）。0以上。 |
| 6 | `tax_rate` | `NUMERIC(4, 2)` | NN, CK, DF | 0.10 | 税率（0以上1未満） |
| 7 | `genre_id` | `BIGINT` | NN, FK | - | ジャンルID |
| 8 | `stock_quantity` | `INTEGER` | NN, CK, DF | 0 | 在庫数（0以上） |
| 9 | `status` | `SMALLINT` | NN, CK, DF | 1 | 公開状態（0:非公開 1:販売中 2:廃番） |
| 10 | `sort_order` | `INTEGER` | NN, DF | 0 | 表示順 |
| 11 | `created_at` | `TIMESTAMPTZ` | NN, DF | CURRENT_TIMESTAMP | レコード作成日時 |
| 12 | `updated_at` | `TIMESTAMPTZ` | NN, DF | CURRENT_TIMESTAMP | レコード更新日時 |

---

## 制約詳細

### 主キー
- `product_id`

### 外部キー
| カラム名 | 参照テーブル | 参照カラム |
|----------|------------|-----------|
| `genre_id` | `m_genre` | `genre_id` |

### ユニーク制約
- `product_code`

### チェック制約
| 制約名 | 条件 |
|--------|------|
| `ck_m_product_price` | `price >= 0` |
| `ck_m_product_tax_rate` | `tax_rate >= 0 AND tax_rate < 1` |
| `ck_m_product_stock` | `stock_quantity >= 0` |
| `ck_m_product_status` | `status IN (0, 1, 2)` |

---

## DDL

```sql
CREATE TABLE m_product (
    product_id       BIGSERIAL       NOT NULL,
    product_code     VARCHAR(50)     NOT NULL,
    product_name     VARCHAR(255)    NOT NULL,
    description      TEXT            NULL,
    price            NUMERIC(10, 2)  NOT NULL
                         CONSTRAINT ck_m_product_price CHECK (price >= 0),
    tax_rate         NUMERIC(4, 2)   NOT NULL DEFAULT 0.10
                         CONSTRAINT ck_m_product_tax_rate CHECK (tax_rate >= 0 AND tax_rate < 1),
    genre_id         BIGINT          NOT NULL
                         REFERENCES m_genre(genre_id),
    stock_quantity   INTEGER         NOT NULL DEFAULT 0
                         CONSTRAINT ck_m_product_stock CHECK (stock_quantity >= 0),
    status           SMALLINT        NOT NULL DEFAULT 1
                         CONSTRAINT ck_m_product_status CHECK (status IN (0, 1, 2)),
    sort_order       INTEGER         NOT NULL DEFAULT 0,
    created_at       TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_m_product PRIMARY KEY (product_id),
    CONSTRAINT uq_m_product_code UNIQUE (product_code)
);

COMMENT ON TABLE m_product IS '商品マスタ';
COMMENT ON COLUMN m_product.product_id IS '主キー';
COMMENT ON COLUMN m_product.product_code IS '商品番号（SKUコードなど）';
COMMENT ON COLUMN m_product.product_name IS '商品名';
COMMENT ON COLUMN m_product.description IS '商品説明';
COMMENT ON COLUMN m_product.price IS '販売価格（税抜）';
COMMENT ON COLUMN m_product.tax_rate IS '税率（例: 0.10 = 10%）';
COMMENT ON COLUMN m_product.genre_id IS 'ジャンルID（m_genre参照）';
COMMENT ON COLUMN m_product.stock_quantity IS '在庫数';
COMMENT ON COLUMN m_product.status IS '公開状態（0:非公開 1:販売中 2:廃番）';
COMMENT ON COLUMN m_product.sort_order IS '表示順';
COMMENT ON COLUMN m_product.created_at IS 'レコード作成日時';
COMMENT ON COLUMN m_product.updated_at IS 'レコード更新日時';
```

---

## 備考

- `updated_at` の自動更新はアプリケーション側またはトリガーで対応すること
- `status` の値は定数化してアプリケーション側で管理すること（0:非公開 / 1:販売中 / 2:廃番）
