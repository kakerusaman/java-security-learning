---
name: er-diagram
description: >
  docs/tables/ 配下のテーブル設計書（Markdown）を読み込み、Draw.io XML形式のER図を生成するスキル。
  テーブル間のリレーションを矢印で表現し、docs/er/ 配下に出力する。
  「ER図を作りたい」「テーブルの関係を図にしたい」「リレーションを可視化したい」
  といったフレーズが出た際はこのスキルを使うこと。
  Claude Codeでの使用を前提とする。
---

# ER Diagram — Draw.io ER図生成スキル

`docs/tables/` 配下のテーブル設計書を読み込み、Draw.io XML形式のER図を `docs/er/` 配下に出力する。

---

## 出力ファイル

| ファイル | 内容 |
|----------|------|
| `docs/er/YYYY-MM-DD_er-diagram.drawio` | Draw.io XML形式のER図 |

---

## ワークフロー

### Step 1: テーブル設計書の収集

```bash
# docs/tables/ 配下の全設計書を読み込む
ls docs/tables/*.md
```

各設計書から以下を抽出する：
- テーブル名
- カラム名・型・制約
- 外部キー（参照先テーブル・カラム）

---

### Step 2: テーブル種別の色分け

| 種別 | プレフィックス | fillColor | strokeColor |
|------|--------------|-----------|-------------|
| トランザクション系 | `t_` | `#dae8fc` | `#6c8ebf` |
| マスター系 | `m_` | `#d5e8d4` | `#82b366` |

---

### Step 3: リレーション記法

カーディナリティを矢印スタイルで表現する：

| 関係 | startArrow | endArrow | 説明 |
|------|-----------|---------|------|
| 1対多 | `ERone` | `ERmany` | 親テーブル → 子テーブル |
| 1対1 | `ERone` | `ERone` | 1対1の関係 |
| 多対多 | `ERmany` | `ERmany` | 中間テーブルを介して表現 |

---

### Step 4: ファイル生成

```bash
mkdir -p docs/er
DATE=$(date +%Y-%m-%d)
# 出力: docs/er/${DATE}_er-diagram.drawio
```

---

## Draw.io XML テンプレート

```xml
<?xml version="1.0" encoding="UTF-8"?>
<mxGraphModel dx="1422" dy="762" grid="1" gridSize="10" guides="1"
              tooltips="1" connect="1" arrows="1" fold="1"
              page="1" pageScale="1" pageWidth="1169" pageHeight="827"
              math="0" shadow="0">
  <root>
    <mxCell id="0"/>
    <mxCell id="1" parent="0"/>

    <!-- テーブルノード（マスター系: 緑） -->
    <mxCell id="tbl_m_user" value="m_user" style="shape=table;startSize=30;container=1;collapsible=1;childLayout=tableLayout;fixedRows=1;rowLines=0;fontStyle=1;align=center;resizeLast=1;fillColor=#d5e8d4;strokeColor=#82b366;" vertex="1" parent="1">
      <mxGeometry x="80" y="80" width="220" height="150" as="geometry"/>
    </mxCell>

    <!-- ヘッダー行（テーブル名） -->
    <mxCell id="tbl_m_user_h" value="" style="shape=tableRow;horizontal=0;startSize=0;swimlaneHead=0;swimlaneBody=0;fillColor=none;collapsible=0;dropTarget=0;points=[[0,0.5],[1,0.5]];portConstraint=eastwest;fontSize=12;top=0;left=0;right=0;bottom=1;" vertex="1" parent="tbl_m_user">
      <mxGeometry y="30" width="220" height="10" as="geometry"/>
    </mxCell>

    <!-- カラム行 -->
    <mxCell id="tbl_m_user_c1" value="PK | id | BIGSERIAL | NOT NULL | 主キー" style="shape=tableRow;horizontal=0;startSize=0;swimlaneHead=0;swimlaneBody=0;fillColor=none;collapsible=0;dropTarget=0;points=[[0,0.5],[1,0.5]];portConstraint=eastwest;top=0;left=0;right=0;bottom=0;" vertex="1" parent="tbl_m_user">
      <mxGeometry y="40" width="220" height="30" as="geometry"/>
    </mxCell>

    <!-- 外部キーのリレーション矢印 -->
    <mxCell id="rel_1" value="" style="edgeStyle=entityRelationEdgeStyle;startArrow=ERone;endArrow=ERmany;exitX=1;exitY=0.5;entryX=0;entryY=0.5;" edge="1" source="tbl_m_user_c1" target="tbl_t_order_c2" parent="1">
      <mxGeometry relative="1" as="geometry"/>
    </mxCell>

  </root>
</mxGraphModel>
```

---

## テーブルノードの生成ルール

### 1テーブルあたりのセル構成

```
[テーブルノード（コンテナ）]
  └─ [ヘッダー区切り行]
  └─ [カラム行 × カラム数]
```

### カラム行の value フォーマット

```
{制約} | {カラム名} | {型} | {NULL可否} | {説明}
```

例：
```
PK     | id         | BIGSERIAL    | NOT NULL | 主キー
FK, NN | user_id    | BIGINT       | NOT NULL | ユーザーID
NN     | name       | VARCHAR(100) | NOT NULL | 名前
       | memo       | TEXT         | NULL     | メモ
```

### ノードIDの命名規則

| 対象 | ID形式 |
|------|--------|
| テーブルコンテナ | `tbl_{テーブル名}` |
| ヘッダー区切り | `tbl_{テーブル名}_h` |
| カラム行 | `tbl_{テーブル名}_c{連番}` |
| リレーション | `rel_{連番}` |

---

## レイアウト方針

- マスター系（`m_`）テーブルを**左側・上部**に配置
- トランザクション系（`t_`）テーブルを**右側・下部**に配置
- テーブル間の間隔: 横 80px、縦 40px 以上空ける
- テーブルの幅: 220px 固定、高さはカラム数に応じて自動調整（30px + カラム数 × 30px）

---

## Claude Codeでの登録方法

`.claude/commands/er-diagram.md` を作成：

```markdown
er-diagramスキルの手順に従い、ER図を作成してください。
対象: $ARGUMENTS（未指定の場合は docs/tables/ 配下の全テーブルを対象とする）

docs/er/YYYY-MM-DD_er-diagram.drawio を生成してください。
テーブル種別（t_ / m_）に応じて色分けし、外部キーのリレーションを矢印で表現すること。
```

使用時：
```
/er-diagram
/er-diagram m_user,t_order
```

---

## 注意事項

- mxCell の `id` は重複しないよう管理すること
- 外部キーの矢印は **参照元カラム行 → 参照先カラム行** を結ぶ（テーブルコンテナ同士ではなくカラム行を指定）
- テーブル数が多い場合（10テーブル以上）は swimlane グループでマスター系・トランザクション系をまとめること
- `docs/tables/` に設計書がない場合は、先に `table-designer` スキルでテーブル設計書を作成するようユーザーに促すこと
