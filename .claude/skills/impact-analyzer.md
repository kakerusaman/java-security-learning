---
name: impact-analyzer
description: >
  Java/KotlinプロジェクトでGitの変更箇所を特定し、モジュール・レイヤー単位の影響範囲を分析するスキル。
  メインレポート（impact-report.md）と Draw.io フロー図（impact-flow.drawio）の2ファイルを出力する。
  コードレビュー前、PR作成時、リファクタリング後、デプロイ前の影響確認など、変更の影響を把握したい場面で必ず使用すること。
  「影響範囲を調べて」「どこに影響する？」「変更箇所をまとめて」「PRの説明を作りたい」「テスト対象を洗い出して」
  「フロー図を作って」「データの流れを見たい」といったフレーズが出た際は積極的にこのスキルを使うこと。
  Claude Codeでの使用を前提とする。
---

# Impact Analyzer — Java/Kotlin 変更影響範囲分析スキル

Gitの差分からJava/Kotlinプロジェクトの変更を解析し、以下の **2ファイル** を出力する。

| ファイル | 内容 | 開き方 |
|----------|------|--------|
| `docs/impact/YYYY-MM-DD_impact-report.md` | 変更一覧・サマリー・確認チェックリスト | 任意のエディタ |
| `docs/impact/YYYY-MM-DD_impact-flow.drawio` | Draw.io フロー図（波及フロー＋ユースケースフロー） | VS Code Draw.io拡張 |

---

## 前提・依存

- `git` コマンドが使用可能であること
- Java/Kotlin プロジェクト（Maven / Gradle どちらでも可）
- プロジェクトルートで実行すること
- VS Code に [Draw.io Integration](https://marketplace.visualstudio.com/items?itemName=hediet.vscode-drawio) 拡張がインストールされていること

---

## ワークフロー

### Step 1: 変更ファイルの取得

```bash
# ステージング済み + 未ステージの変更（デフォルト）
git diff --name-only HEAD

# 特定ブランチとの比較（PR用）
git diff --name-only main...HEAD

# 直近のコミット
git diff --name-only HEAD~1 HEAD
```

ユーザーが対象範囲を指定していない場合は `git diff --name-only HEAD` を使う。

---

### Step 2: プロジェクト構造の把握

**典型的なJava/Kotlinプロジェクトのレイヤー構造：**

| レイヤー | パターン例 | 説明 |
|----------|-----------|------|
| `controller` / `api` | `*Controller.java`, `*Resource.kt` | エントリーポイント |
| `service` | `*Service.java`, `*UseCase.kt` | ビジネスロジック |
| `repository` / `dao` | `*Repository.java`, `*Dao.kt` | データアクセス |
| `domain` / `model` | `*Entity.java`, `*Domain.kt` | ドメインモデル |
| `dto` | `*Dto.java`, `*Request.kt`, `*Response.kt` | データ転送オブジェクト |
| `config` | `*Config.java`, `*Configuration.kt` | 設定クラス |
| `util` / `helper` | `*Util.java`, `*Helper.kt` | ユーティリティ |
| `test` | `*Test.java`, `*Spec.kt` | テストコード |

```bash
# モジュール構成を確認
find . -name "build.gradle" -o -name "pom.xml" | grep -v ".gradle/" | head -20

# パッケージ構成を確認
find src/main -type d | head -30
```

---

### Step 3: 変更の分類と影響分析

#### 3-1. 差分の内容確認

```bash
# メソッドシグネチャレベルで変更を確認
git diff HEAD -- path/to/ChangedFile.java | grep "^[+-]" | grep -E "(public|protected|private|fun |def )"

# DBアクセスの変更を確認
git diff HEAD -- path/to/ChangedFile.java | grep -E "(@Query|SELECT|INSERT|UPDATE|DELETE|findBy)"
```

#### 3-2. 2種類のフローを構築

**① 変更波及フロー**（変更がどこに広がるか）
- 変更されたファイル・クラスを起点にする
- 依存している上位レイヤーへの波及を矢印で示す
- DBのテーブル・カラム名まで追う

**② ユースケースフロー**（機能の入口→処理→DB）
- APIエンドポイント・イベントなどトリガーを起点にする
- Controller → Service → Repository → DB の流れを示す
- 変更箇所をオレンジ色でハイライトする

---

### Step 4: 2ファイルを生成する

```bash
mkdir -p docs/impact
DATE=$(date +%Y-%m-%d)
```

---

## ファイル① impact-report.md テンプレート

```markdown
# 変更影響範囲レポート

**生成日時**: YYYY-MM-DD HH:mm
**対象**: `feature/xxx` → `main`
**変更ファイル数**: N件
**フロー図**: [impact-flow.drawio](./YYYY-MM-DD_impact-flow.drawio) をVS CodeのDraw.io拡張で開く

---

## サマリー

| 項目 | 内容 |
|------|------|
| 影響レイヤー | Controller, Service, Repository |
| 影響DB | t_user_info（emailカラム） |
| 変更モジュール | user-service |
| 外部連携 | メール送信API |

---

## 変更ファイル一覧

| ファイル | レイヤー | 変更種別 |
|----------|----------|----------|
| `src/.../UserService.java` | Service | ロジック修正 |
| `src/.../UserRepository.java` | Repository | クエリ変更 |
| `src/.../UserDto.java` | DTO | フィールド追加 |

---

## 確認チェックリスト

### UserRepository（クエリ変更）
- [ ] 変更後のクエリで既存データが正しく取得できるか
- [ ] `t_user_info.email` カラムの制約と整合しているか
- [ ] `UserService` のユニットテストを再実行

### UserService（ロジック修正）
- [ ] `UserServiceTest` の全テストケースが通ること
- [ ] メール送信の冪等性（重複送信しないか）を確認

---

## 推奨テスト範囲

| テスト種別 | 対象 | 優先度 |
|-----------|------|--------|
| ユニットテスト | `UserServiceTest`, `UserRepositoryTest` | 必須 |
| 結合テスト | `POST /api/users/email` エンドポイント | 推奨 |
| 回帰テスト | 認証フロー全体 | 任意 |
```

---

## ファイル② impact-flow.drawio の生成ルール

`.drawio` ファイルは **Draw.io XML形式** で生成する。
以下のテンプレート構造をベースに、分析結果に応じてノードと矢印を追加・編集すること。

### XMLテンプレート構造

```xml
<?xml version="1.0" encoding="UTF-8"?>
<mxGraphModel dx="1422" dy="762" grid="1" gridSize="10" guides="1"
              tooltips="1" connect="1" arrows="1" fold="1"
              page="1" pageScale="1" pageWidth="1169" pageHeight="827"
              math="0" shadow="0">
  <root>
    <mxCell id="0"/>
    <mxCell id="1" parent="0"/>

    <!-- ページ1: 変更波及フロー -->
    <mxCell id="page1" value="変更波及フロー" style="swimlane;" vertex="1" parent="1">
      <mxGeometry x="0" y="0" width="1100" height="600" as="geometry"/>
    </mxCell>

    <!-- 変更ノード（オレンジ） -->
    <mxCell id="n1" value="UserRepository.java&#xa;クエリ変更"
            style="rounded=1;fillColor=#f96;strokeColor=#c60;fontStyle=1;"
            vertex="1" parent="page1">
      <mxGeometry x="80" y="80" width="200" height="60" as="geometry"/>
    </mxCell>

    <!-- 影響先ノード（水色） -->
    <mxCell id="n2" value="UserService.java"
            style="rounded=1;fillColor=#dae8fc;strokeColor=#6c8ebf;"
            vertex="1" parent="page1">
      <mxGeometry x="380" y="80" width="200" height="60" as="geometry"/>
    </mxCell>

    <!-- DBノード（緑） -->
    <mxCell id="n3" value="DB: t_user_info&#xa;.email カラム"
            style="shape=cylinder3;fillColor=#d5e8d4;strokeColor=#82b366;"
            vertex="1" parent="page1">
      <mxGeometry x="680" y="240" width="160" height="80" as="geometry"/>
    </mxCell>

    <!-- 外部システムノード（黄） -->
    <mxCell id="n4" value="外部: メール送信サーバー"
            style="ellipse;fillColor=#fff2cc;strokeColor=#d6b656;"
            vertex="1" parent="page1">
      <mxGeometry x="680" y="80" width="200" height="60" as="geometry"/>
    </mxCell>

    <!-- 矢印 -->
    <mxCell id="e1" value="戻り値変更の可能性" style="edgeStyle=orthogonalEdgeStyle;"
            edge="1" source="n1" target="n2" parent="page1">
      <mxGeometry relative="1" as="geometry"/>
    </mxCell>
    <mxCell id="e2" value="email更新" style="edgeStyle=orthogonalEdgeStyle;"
            edge="1" source="n2" target="n3" parent="page1">
      <mxGeometry relative="1" as="geometry"/>
    </mxCell>
    <mxCell id="e3" value="送信トリガー" style="edgeStyle=orthogonalEdgeStyle;"
            edge="1" source="n2" target="n4" parent="page1">
      <mxGeometry relative="1" as="geometry"/>
    </mxCell>

  </root>
</mxGraphModel>
```

---

### ノードのスタイル定義

| 種別 | fillColor | strokeColor | shape |
|------|-----------|-------------|-------|
| 変更箇所（ハイライト） | `#f96` | `#c60` | rounded=1 |
| Controller / API | `#ffe6cc` | `#d79b00` | rounded=1 |
| Service | `#dae8fc` | `#6c8ebf` | rounded=1 |
| Repository | `#e1d5e7` | `#9673a6` | rounded=1 |
| Domain / Entity | `#f8cecc` | `#b85450` | rounded=1 |
| DB テーブル | `#d5e8d4` | `#82b366` | shape=cylinder3 |
| 外部システム | `#fff2cc` | `#d6b656` | ellipse |
| 折りたたみグループ | `#f5f5f5` | `#666666` | swimlane;foldable=1 |

---

### 折りたたみグループの作り方

Draw.io では `swimlane` スタイルに `foldable=1` を付けることで、
VS Code上でクリックして折りたたむことができる。

```xml
<!-- 折りたたみ可能なグループ -->
<mxCell id="grp1" value="Service層" 
        style="swimlane;foldable=1;fillColor=#dae8fc;strokeColor=#6c8ebf;"
        vertex="1" parent="1">
  <mxGeometry x="300" y="100" width="300" height="200" as="geometry"/>
</mxCell>

<!-- グループ内のノードは parent="grp1" にする -->
<mxCell id="n5" value="UserService.java"
        style="rounded=1;fillColor=#dae8fc;strokeColor=#6c8ebf;"
        vertex="1" parent="grp1">
  <mxGeometry x="50" y="60" width="200" height="60" as="geometry"/>
</mxCell>
```

グループ単位（Controller層・Service層・Repository層・DB層）で折りたたむことで、
複雑なフローでも見やすく管理できる。

---

### ページ分割（複数タブ）

Draw.io は1ファイルに複数ページを持てる。波及フローとユースケースフローを別ページに分ける：

```xml
<!-- ページ切り替えはmxGraphModelの直下にpageセルを並べる -->
<!-- page="1" が表示ページ番号に対応 -->
```

ただし、Claude Codeが生成するXMLでは**1ページに2つのswimlanグループを並べる**方式を基本とする（ページ分割はXML構造が複雑になるため）。

---

## Claude Codeでの登録方法

`.claude/commands/impact-report.md` を作成：

```markdown
impact-analyzerスキルの手順に従い、変更影響範囲の分析を行ってください。
対象: $ARGUMENTS（未指定の場合は git diff --name-only HEAD を使用）

以下の2ファイルを docs/impact/ 配下に生成してください：
1. YYYY-MM-DD_impact-report.md（サマリー・チェックリスト）
2. YYYY-MM-DD_impact-flow.drawio（Draw.io XML形式のフロー図）

.drawioファイルはVS CodeのDraw.io拡張で開けるXML形式で生成すること。
変更箇所のノードはオレンジ色（fillColor=#f96）でハイライトし、
レイヤーごとにfoldable=1のswimlanグループでまとめること。
```

使用時：
```
/impact-report
/impact-report main...HEAD
```

---

## 注意事項・制限

- **動的依存関係**（Spring の `@Autowired` や DI コンテナ）は静的解析では追いきれない。`要確認` ノードを置いて明示すること。
- **マルチモジュールプロジェクト**では `settings.gradle` / `pom.xml` からモジュール間依存を読み取ること。
- Kotlinの **拡張関数・データクラス** の変更は利用箇所が広範になりやすいため、波及フローに漏れなく含めること。
- ノードが20個を超える場合は swimlane グループを活用して折りたたみ、図を見やすく保つこと。
- mxCell の `id` は重複しないよう連番で管理すること。
