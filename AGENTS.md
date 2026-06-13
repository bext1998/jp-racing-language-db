# AGENTS.md

本檔案定義 `D:\AgentCoding\CarrrotWinClub` 專案內 Codex / coding agent 的工作規則。若與使用者最新指示衝突，以使用者最新指示為準；若與全域 `AGENTS.md` 衝突，除非本檔明確覆寫，仍遵守全域規則。

## 專案定位

- 本專案服務「日本賽馬共同語言資料庫」。
- 主要目標是讓 Codex / coding agent 能在專案內查詢、翻譯、統一術語與理解日本賽馬語境。
- 第一版以 Markdown 文件為主，不建立 API、網站、資料庫服務或自動化 ingestion pipeline。
- 資料庫應保持低雜訊、可搜尋、可追溯來源可信度。

## 回覆與工作語言

- 所有說明、計畫、變更摘要與問題分析一律使用繁體中文。
- 賽馬專有名詞可保留日文、英文或羅馬字，不為了中文化而硬翻。
- 對譯名、來源或語境不確定時，必須明確標示假設與不確定性。

## 工作範圍與非目標

- 可維護 `docs/racing-language/` 下的共同語言文件。
- 不應把本專案擴張成百科、完整馬匹資料庫、賽事資料庫或即時資料服務。
- 第一版不大量收錄知名馬名。
- 沒有可靠中文譯名的馬名，不主動翻譯。

## Agent Configuration Rules

- 建立 Codex 自訂 subagent 時，必須使用 Codex 原生的 `.codex/config.toml` 與 TOML agent 設定。
- 不得在 `.claude/agents/` 中新增或修改檔案，除非使用者明確要求建立 Claude Code subagent。
- `.claude/` 僅供 Claude Code 使用；`.codex/` 僅供 Codex 使用。
- 若工作要求跨 Harness 相容，必須先建立中立來源規格，再分別產生 Claude Code 與 Codex 的適配檔案。

## Racing Language 資料庫入口規則

- 查詢日本賽馬術語時，應先讀 `docs/racing-language/INDEX.md`。
- 讀完 `INDEX.md` 後，再依分類讀取目標詞條檔。
- 不應一開始載入整個 `docs/racing-language/`，避免上下文雜訊過高。
- 若 `INDEX.md` 與分類檔不一致，優先回報不一致，不自行猜測並大規模修正。

## 詞條檔案責任邊界

- `docs/racing-language/INDEX.md`
  - AI 查詢入口。
  - 放用途、查詢流程、分類地圖、常用搜尋關鍵字、檔案責任邊界。
- `docs/racing-language/terms/basic-racing.md`
  - 放基礎觀賽、投注、馬場、名次、距離、出走、讓磅等術語。
- `docs/racing-language/terms/breeding-bloodlines.md`
  - 放育種、血統、種牡馬、繁殖牝馬、血統表等術語。
- `docs/racing-language/terms/global-racing-terms.md`
  - 放英美澳等國際賽馬用語、投注與賽事環境術語。
- `docs/racing-language/terms/japanese-racing-system.md`
  - 放日本賽制、中央競馬、地方競馬、重賞、G1/G2/G3、Listed、OP、條件戰等術語。
- `docs/racing-language/terms/jra-g1-races.md`
  - 放 JRA G1 與主要重賞賽事名稱、距離、場地與歷史背景。
- `docs/racing-language/terms/jumps-racing.md`
  - 放障礙賽、跳欄、越野、障礙賽制度與相關術語。
- `docs/racing-language/terms/race-analysis.md`
  - 放腳質、末腳、折合、掛かる、馬場適性、調教、血統傾向等分析用語。
- `docs/racing-language/terms/racing-equipment.md`
  - 放馬具、裝備、配件與出賽裝備相關術語。
- `docs/racing-language/horses/horses.md`
  - 唯一馬名 canonical 檔。
  - 放馬名、種牡馬、繁殖牝馬、現役馬與退役名馬；不得依地區、賽事或年代另開重複馬名檔。
- `docs/racing-language/people/racing-people.md`
  - 放騎師、練馬師、馬主、育馬者、賽馬組織關係人等具名人物。
- `docs/racing-language/references/source-policy.md`
  - 放來源分級、引用規則、來源 URL、使用範圍。
- `docs/racing-language/references/glossary-style.md`
  - 放譯名選擇規則、同義詞處理、暫定譯名、馬名處理規則。

## 詞條格式與欄位規則

- 分類詞條檔以 Markdown 表格為主。
- 表格欄位固定為：

```markdown
| ID | 主譯名 | 日文 | 英文 | 分類 | 定義 | 使用語境 | 相關詞 | 譯名狀態 | 來源等級 |
|---|---|---|---|---|---|---|---|---|---|
```

- `ID` 必須唯一，依分類使用固定前綴，例如 `BR-001`、`JRS-001`、`RA-001`。
- `定義` 以 1 句為主，最多 2 句。
- `相關詞` 只列直接相關詞，不建立長篇知識網。
- `譯名狀態` 只能使用 `官方`、`常用`、`暫定`、`需確認`。
- `來源等級` 只能使用 `A`、`B`、`C`、`D`。
- 詳細來源 URL 不放入每一列，集中放在 `references/source-policy.md`。

## 來源分級與譯名決策

- `A`：高可信中文來源，例如 HKJC 官方中文資料、香港賽馬會賽例 / 投注 / 馬匹資料、JRA 官方繁中資料。
- `B`：高可信原文或英文來源，例如 JRA 官方日文 / 英文資料、Horse Racing in Japan、netkeiba 英文版、JBIS 等。
- `C`：背景補充來源，例如維基百科、日英詞典、一般賽馬介紹文章。只能補背景，不可單獨決定主譯名。
- `D`：待確認資料，例如由語境推定、社群常用、暫無正式來源。可收錄，但必須標為 `暫定` 或 `需確認`。
- 有 HKJC 或 JRA 繁中譯名時，優先採用。
- 沒有官方中文譯名，但有可信日文 / 英文語境時，可建立正體中文暫定譯名。
- 維基百科不可作為唯一權威來源。
- 同一術語有多個中文說法時，只選一個 `主譯名`，其他說法放入 `相關詞` 或註記。
- `暫定`、`需確認` 詞條不得被當成權威譯名。
- 不可為了資料完整性創造無來源譯名。

## 馬名處理規則

- 馬名比術語更保守。
- 沒有可靠中文譯名時，保留日文名、英文名或羅馬字。
- 只有在 HKJC、JRA 繁中、可信正體中文來源等已有譯名時，才記錄中文馬名。
- 第一版不主動建立大量馬名資料。
- `docs/racing-language/horses/horses.md` 是唯一馬名 canonical 檔。
- 馬名不得依地區、賽事或年代另開重複檔；同一馬名只允許一筆 canonical 詞條。
- 種牡馬、現役馬、退役名馬若本質仍是馬匹，也放在 `horses/horses.md`，用 `分類` 與 `使用語境` 區分。
- `horses/horses.md` 不得收錄人物、賽事、賽道、機構、馬具、投注方式或一般術語。
- 若候選主譯名、日文或英文含 `Cup`、`Stakes`、`Derby`、`Oaks`、`Guineas`、`Plate`、`Racecourse`、`Racing Club`、`Association`、`Stud`、`Farm` 等高風險詞，不得直接寫入 `horses/horses.md`；必須先確認它本質是否真為馬匹。
- 若定義主詞是騎師、練馬師、調教師、馬主、育馬者、賽事、賽馬場、競馬場、機構或組織，不得放入 `horses/horses.md`。
- 若定義或使用語境明確寫出「非指本馬」、「紀念賽事」、「比賽」、「每年舉行」等語意，應優先判定為非馬名並移至對應分類檔或標記待確認。

## 實體類型與責任邊界檢查

- 新增任何詞條前，必須先判斷候選資料的實體類型：`馬匹`、`人物`、`賽事`、`賽道`、`機構`、`術語`、`裝備` 或 `不明`。
- 實體類型為 `不明` 時，不得直接寫入正式詞條檔；應先列為候選或回報待確認。
- 查重必須跨整個 `docs/racing-language/`，不可只查預計寫入的單一檔案。
- 若同一主譯名、日文名或英文名已存在於其他責任邊界，必須先判斷是否為同一概念、同名不同物、上下位詞或誤置；不確定時不得新增重複 canonical 詞條。
- 修改 `horses/horses.md` 後，必須執行 `scripts/check-horse-entry-scope.ps1`，確認沒有明確非馬名資料混入。
- 修改多個分類檔、搬移詞條或批次新增資料後，必須執行 `scripts/check-racing-entry-scope.ps1`，檢查跨檔責任邊界與同名風險。
- scope 檢查中的 `ERRORS` 必須修正後才能宣告完成；`WARNINGS` 可保留，但回報時必須說明是否為既有資料或需後續人工確認。

## Codex 查詢流程

1. 先讀 `docs/racing-language/INDEX.md`。
2. 根據分類地圖判斷要查 `terms/basic-racing.md`、`terms/japanese-racing-system.md` 或 `terms/race-analysis.md`。
3. 使用 `rg` 搜尋日文、中文、英文、ID 或相關詞。
4. 若查不到詞條，不要直接創造譯名；應說明查無資料，並視任務需要提出候選新增方式。
5. 若詞條狀態為 `暫定` 或 `需確認`，回覆時必須保留不確定性。
6. 若涉及馬名，先確認是否有可靠中文名；沒有時不翻譯。

## 維護與新增詞條流程

新增術語時應依序執行：

1. 確認分類。
2. 搜尋既有詞條與近似詞，避免重複。
3. 補齊核心欄位：`ID`、`主譯名`、`日文`、`英文`、`分類`、`定義`、`使用語境`、`相關詞`、`譯名狀態`、`來源等級`。
4. 若來源不足，標為 `D`，譯名狀態標為 `暫定` 或 `需確認`。
5. 日本制度詞放入 `japanese-racing-system.md`。
6. 分析用語放入 `race-analysis.md`。
7. 基礎觀賽與一般賽馬詞放入 `basic-racing.md`。
8. 馬名、種牡馬、繁殖牝馬、現役馬與退役名馬放入 `horses/horses.md`。
9. 具名騎師、練馬師、馬主、育馬者或賽馬關係人放入 `people/racing-people.md`。
10. 若新增來源類型或引用策略，更新 `references/source-policy.md`。
11. 若新增譯名判斷規則，更新 `references/glossary-style.md`。

## 新增前與收集後查重規則

Claude Code 或其他 agent 蒐集新資料前，必須先確認候選資料是否已經填入：

1. 先用候選資料的中文、日文、英文、羅馬字、別名與常見縮寫搜尋本資料庫。
2. 單筆候選使用 `scripts/check-racing-entry.ps1 -Query "候選詞"`。
3. 多筆候選先建立 UTF-8 文字檔，每行一個候選詞，再使用 `scripts/check-racing-entry.ps1 -InputPath candidates.txt`；需要列出命中列時加上 `-Detailed`。
4. 若查到同一概念或同一馬名，不新增重複詞條；只在必要時補強既有列的 `相關詞`、`使用語境` 或來源清單。
5. 若只查到近似詞，先判斷是否為同義詞、上下位詞、不同賽事、不同馬匹或不同機構；不確定時標記待確認，不自行合併。
6. 若完全查不到，才依分類責任邊界新增詞條，並使用下一個連續 ID。
7. agent 蒐集完候選資料後，新增或修改前必須再查重一次。
8. 寫入或修改後，必須再次執行查重與一致性驗證；若第二次查重發現重複，不可留下重複列。
9. 確認為同一概念、同一馬名或同一人物的重複資料時，應刪除重複列，只保留一筆 canonical 詞條；必要資訊合併到保留列的 `相關詞`、`使用語境` 或定義中。
10. 若相似資料是否重複仍無法確認，不可刪除；應保留較可信列並將另一列標記為 `需確認`，或先回報待人工確認。

一致性驗證使用：

```powershell
./scripts/validate-racing-language.ps1
./scripts/check-horse-entry-scope.ps1
./scripts/check-racing-entry-scope.ps1
```

## 驗證規則

修改後應盡可能檢查：

- Markdown 表格欄位是否一致。
- ID 是否重複。
- `譯名狀態` 是否只使用固定值。
- `來源等級` 是否只使用 `A/B/C/D`。
- `INDEX.md` 是否指向所有分類檔。
- 是否違反「馬名不硬翻」。
- `horses/horses.md` 是否無重複主譯名與英文名。
- 舊馬名分檔是否已不存在且未被文件引用。

固定結構驗證應執行：

```powershell
./scripts/validate-racing-language.ps1
```

責任邊界驗證應依修改範圍執行：

```powershell
./scripts/check-horse-entry-scope.ps1
./scripts/check-racing-entry-scope.ps1
```

可用 `rg` 檢查 ID、主譯名、分類與重複詞。不可聲稱驗證通過，除非實際執行過相關檢查。

## 禁止事項

- 不硬編、捏造或自創沒有來源的中文譯名。
- 不把 `D` 級來源或推測內容標成官方。
- 不用維基百科單獨決定主譯名。
- 不把詳細來源 URL 塞進每個詞條列，避免表格噪音。
- 不把詞條寫成百科長文。
- 不在第一版擴張成 API、網站、完整馬匹資料庫或即時賽事資料系統。
- 不為了補齊欄位而填入不確定內容；應留空或標示需確認。

## 不應放在 AGENTS.md 的內容

以下內容應留在 `docs/racing-language/` 的資料庫文件、QA 報告或維護紀錄中：

- 實際詞條內容與完整術語表。
- 每個來源的詳細 URL 清單。
- 具體引用段落、來源摘要與版本記錄。
- 大量馬名清單或馬匹背景資料。
- 每個術語的長篇解釋、歷史背景、賽事案例。
- 批次收集計畫與每批新增詞條的工作清單。
- 未來 API / 網站 / 資料庫服務的詳細技術設計。
- 大量範例表格列。
