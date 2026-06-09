# テーブル設計書：m_coupon

## 基本情報

| 項目 | 内容 |
|------|------|
| テーブル名 | `m_coupon` |
| 種別 | マスター系 |
| 説明 | 割引クーポンの定義を管理する。金額割引・パーセント割引の2種類に対応し、有効期間を設定できる。 |
| DB | PostgreSQL |
| 作成日 | 2026-06-09 |

---

## カラム定義

| # | カラム名 | 型 | 制約 | デフォルト値 | 説明 |
|---|----------|----|------|-------------|------|
| 1 | `coupon_id` | `BIGSERIAL` | PK | - | 主キー |
| 2 | `coupon_code` | `VARCHAR(50)` | NN, UQ | - | クーポンコード |
| 3 | `discount_type` | `SMALLINT` | NN, CK | - | 割引種別（1:金額割引 2:パーセント割引） |
| 4 | `discount_value` | `NUMERIC(10, 2)` | NN, CK | - | 割引値（金額 or パーセント）。0より大きい値。 |
| 5 | `start_at` | `TIMESTAMPTZ` | NN | - | 有効期間開始日時 |
| 6 | `end_at` | `TIMESTAMPTZ` | NN, CK | - | 有効期間終了日時（start_atより後） |
| 7 | `created_at` | `TIMESTAMPTZ` | NN, DF | CURRENT_TIMESTAMP | レコード作成日時 |
| 8 | `updated_at` | `TIMESTAMPTZ` | NN, DF | CURRENT_TIMESTAMP | レコード更新日時 |

---

## 制約詳細

### 主キー
- `coupon_id`

### ユニーク制約
- `coupon_code`

### チェック制約
| 制約名 | 条件 |
|--------|------|
| `ck_m_coupon_discount_type` | `discount_type IN (1, 2)` |
| `ck_m_coupon_discount_value` | `discount_value > 0` |
| `ck_m_coupon_period` | `end_at > start_at` |

---

## DDL

```sql
CREATE TABLE m_coupon (
    coupon_id       BIGSERIAL       NOT NULL,
    coupon_code     VARCHAR(50)     NOT NULL,
    discount_type   SMALLINT        NOT NULL
                        CONSTRAINT ck_m_coupon_discount_type CHECK (discount_type IN (1, 2)),
    discount_value  NUMERIC(10, 2)  NOT NULL
                        CONSTRAINT ck_m_coupon_discount_value CHECK (discount_value > 0),
    start_at        TIMESTAMPTZ     NOT NULL,
    end_at          TIMESTAMPTZ     NOT NULL,
    created_at      TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMPTZ     NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT pk_m_coupon PRIMARY KEY (coupon_id),
    CONSTRAINT uq_m_coupon_code UNIQUE (coupon_code),
    CONSTRAINT ck_m_coupon_period CHECK (end_at > start_at)
);

COMMENT ON TABLE m_coupon IS 'クーポンマスタ';
COMMENT ON COLUMN m_coupon.coupon_id IS '主キー';
COMMENT ON COLUMN m_coupon.coupon_code IS 'クーポンコード（ユーザーが入力する文字列）';
COMMENT ON COLUMN m_coupon.discount_type IS '割引種別（1:金額割引 2:パーセント割引）';
COMMENT ON COLUMN m_coupon.discount_value IS '割引値（金額割引時は円、パーセント割引時は%の数値）';
COMMENT ON COLUMN m_coupon.start_at IS 'クーポン有効期間 開始日時';
COMMENT ON COLUMN m_coupon.end_at IS 'クーポン有効期間 終了日時';
COMMENT ON COLUMN m_coupon.created_at IS 'レコード作成日時';
COMMENT ON COLUMN m_coupon.updated_at IS 'レコード更新日時';
```

---

## 備考

- `discount_type = 2`（パーセント割引）の場合、`discount_value` は 1〜100 の範囲が自然だが、業務要件に応じて追加のCHECK制約を検討すること
- `updated_at` の自動更新はアプリケーション側またはトリガーで対応すること
