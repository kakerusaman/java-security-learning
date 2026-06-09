# テーブル設計書：m_product_coupon

## 基本情報

| 項目 | 内容 |
|------|------|
| テーブル名 | `m_product_coupon` |
| 種別 | マスター系 |
| 説明 | 商品とクーポンの紐付けを管理する中間テーブル。多対多の関係を解消する。 |
| DB | PostgreSQL |
| 作成日 | 2026-06-09 |

---

## カラム定義

| # | カラム名 | 型 | 制約 | デフォルト値 | 説明 |
|---|----------|----|------|-------------|------|
| 1 | `product_id` | `BIGINT` | PK, FK | - | 商品ID |
| 2 | `coupon_id` | `BIGINT` | PK, FK | - | クーポンID |
| 3 | `created_at` | `TIMESTAMPTZ` | NN, DF | CURRENT_TIMESTAMP | レコード作成日時 |

---

## 制約詳細

### 主キー
- `(product_id, coupon_id)` （複合主キー）

### 外部キー
| カラム名 | 参照テーブル | 参照カラム |
|----------|------------|-----------|
| `product_id` | `m_product` | `product_id` |
| `coupon_id` | `m_coupon` | `coupon_id` |

---

## DDL

```sql
CREATE TABLE m_product_coupon (
    product_id   BIGINT          NOT NULL
                     REFERENCES m_product(product_id),
    coupon_id    BIGINT          NOT NULL
                     REFERENCES m_coupon(coupon_id),
    created_at   TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_m_product_coupon PRIMARY KEY (product_id, coupon_id)
);

COMMENT ON TABLE m_product_coupon IS '商品クーポン紐付けマスタ';
COMMENT ON COLUMN m_product_coupon.product_id IS '商品ID（m_product参照）';
COMMENT ON COLUMN m_product_coupon.coupon_id IS 'クーポンID（m_coupon参照）';
COMMENT ON COLUMN m_product_coupon.created_at IS '紐付け作成日時';
```

---

## 備考

- 中間テーブルのため `updated_at` は不要（紐付けの変更は削除＆再登録で対応）
- 商品削除・クーポン削除時の参照整合性（ON DELETE の挙動）は業務要件に合わせて設定すること
