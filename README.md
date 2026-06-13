# 日本賽馬共同語言資料庫

供 AI agent 與研究者查詢、翻譯、統一日本賽馬術語的開放 Markdown 資料庫。

## 資料庫範疇

- 日本中央競馬（JRA）與地方競馬（NAR）術語
- 育種、血統、馬具、比賽分析等專業詞彙
- JRA G1 及主要重賞賽事資訊
- 知名馬名、騎師、練馬師等具名人物
- 國際賽馬用語對照

每個詞條附帶主譯名、日文、英文、定義、使用語境、來源等級與譯名狀態，以確保可追溯性。

## 資料夾結構

```
docs/racing-language/
├── INDEX.md                    # AI 查詢入口，請從這裡開始
├── terms/
│   ├── basic-racing.md         # 基礎觀賽與投注術語
│   ├── breeding-bloodlines.md  # 育種與血統術語
│   ├── global-racing-terms.md  # 國際賽馬用語
│   ├── japanese-racing-system.md # 日本賽制
│   ├── jra-g1-races.md         # JRA G1 賽事
│   ├── jumps-racing.md         # 障礙賽術語
│   ├── race-analysis.md        # 比賽分析用語
│   └── racing-equipment.md     # 馬具與裝備
├── horses/
│   └── horses.md               # 馬名 canonical 檔（唯一）
├── people/
│   └── racing-people.md        # 具名人物
└── references/
    ├── source-policy.md        # 來源分級與 URL 清單
    └── glossary-style.md       # 譯名取捨規則
scripts/
├── check-racing-entry.ps1      # 查重工具
└── validate-racing-language.ps1 # 一致性驗證
```

## 用 AI 貢獻詞條

本 repo 設計為支援 Claude Code 搭配內建 subagent 協作貢獻。`.claude/agents/` 提供以下角色：

| Agent | 職責 |
|---|---|
| `researcher` | 蒐集術語、馬名、人物、賽事等原始資料 |
| `source-manager` | 審核候選詞條、決定來源等級與主譯名 |
| `fact-checker` | 核對定義正確性、找出重複或矛盾詞條 |
| `editor` | 校對格式、表格對齊、語句一致性 |

**貢獻流程（使用 Claude Code）：**

1. Clone 此 repo，用 Claude Code 開啟
2. 閱讀 `docs/racing-language/INDEX.md` 了解分類地圖
3. 閱讀 `CLAUDE.md` 了解詞條格式與工作規則
4. 查重後再新增詞條：
   ```powershell
   ./scripts/check-racing-entry.ps1 -Query "候選詞"
   ```
5. 新增或修改後執行一致性驗證：
   ```powershell
   ./scripts/validate-racing-language.ps1
   ```
6. 提交 Pull Request

## 詞條格式

```markdown
| ID | 主譯名 | 日文 | 英文 | 分類 | 定義 | 使用語境 | 相關詞 | 譯名狀態 | 來源等級 |
```

- `譯名狀態`：`官方` / `常用` / `暫定` / `需確認`
- `來源等級`：`A`（HKJC/JRA 官方中文）→ `B`（官方日英）→ `C`（補充）→ `D`（待確認）

## 貢獻原則

- 不硬翻無來源中文譯名；沒有可靠譯名時保留日文或英文
- 一個概念只有一筆詞條，不重複新增
- 馬名只在 `horses/horses.md` 維護，不另開分檔
- 來源等級決定譯名可信度，`D` 級不可當作官方譯名使用
- 詳細規則見 `CLAUDE.md`

## 授權

本資料庫以 [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/) 授權釋出。
