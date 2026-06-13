# 日本賽馬共同語言資料庫

本資料庫供 Codex / coding agent 查詢日本賽馬術語、馬名對照、翻譯候選與語境。第一版以 Markdown 文件為主，保持低雜訊、可搜尋、可追溯來源可信度。

## 查詢流程

1. 先閱讀本檔判斷分類。
2. 依分類讀取單一目標檔案，不要一次載入全部資料。
3. 使用 `rg` 搜尋中文、日文、英文、ID 或相關詞。
4. 詞條若標示 `暫定` 或 `需確認`，回覆時必須保留不確定性。
5. 馬名若無可靠中文來源，不主動翻譯。

## 新增前查重流程

Claude Code 或其他 agent 蒐集新資料前，必須先確認候選資料是否已經填入：

1. 先用候選資料的中文、日文、英文、羅馬字、別名與常見縮寫搜尋本資料庫。
2. 優先使用 `scripts/check-racing-entry.ps1 -Query "候選詞"` 查詢四個詞條檔。
3. 若有多筆候選資料，先建立 UTF-8 文字檔，每行一個候選詞，使用 `scripts/check-racing-entry.ps1 -InputPath candidates.txt` 批次查重；需要列出命中列時加上 `-Detailed`。
4. 若查到同一概念或同一馬名，不新增重複詞條；只在必要時補強既有列的 `相關詞`、`使用語境` 或來源清單。
5. 若只查到近似詞，先判斷是否為同義詞、上下位詞、不同賽事、不同馬匹或不同機構；不確定時標記待確認，不自行合併。
6. 若完全查不到，才依分類責任邊界新增詞條，並使用下一個連續 ID。
7. 蒐集完候選資料後，寫入前必須再查重一次；寫入後也必須再次執行查重與一致性驗證，確認沒有重複 ID、重複概念或非法欄位值。

一致性驗證使用：

```powershell
./scripts/validate-racing-language.ps1
```

## 分類地圖

| 類型 | 檔案 | 責任邊界 |
|---|---|---|
| 基礎觀賽與投注 | `terms/basic-racing.md` | 投注、馬場、場地、出走、名次、距離、負磅等一般術語 |
| 育種與血統 | `terms/breeding-bloodlines.md` | 育種、血統、種牡馬、繁殖牝馬、血統表等術語 |
| 全球賽馬術語 | `terms/global-racing-terms.md` | 英美澳等國際賽馬用語、投注與賽事環境術語 |
| 日本賽制 | `terms/japanese-racing-system.md` | JRA、NAR、中央競馬、地方競馬、重賞、分級、條件戰等制度詞 |
| JRA G1 賽事 | `terms/jra-g1-races.md` | JRA G1 與主要重賞賽事名稱、距離、場地與歷史背景 |
| 障礙賽 | `terms/jumps-racing.md` | 障礙賽、跳欄、越野、障礙賽制度與相關術語 |
| 比賽分析 | `terms/race-analysis.md` | 腳質、末腳、折合、馬場適性、調教、血統傾向等分析語彙 |
| 馬具與裝備 | `terms/racing-equipment.md` | 馬具、裝備、配件與出賽裝備相關術語 |
| 馬名 | `horses/horses.md` | 唯一馬名 canonical 檔；馬名、種牡馬、繁殖牝馬、現役馬與退役名馬只在此檔維護 |
| 人物 | `people/racing-people.md` | 騎師、練馬師、馬主、育馬者、賽馬組織關係人等具名人物 |
| 來源策略 | `references/source-policy.md` | 來源分級、URL 清單、使用範圍 |
| 詞彙風格 | `references/glossary-style.md` | 譯名取捨、同義詞、暫定譯名、馬名處理 |

## 常用搜尋關鍵字

- 賽制：`中央競馬`、`地方競馬`、`JRA`、`NAR`、`重賞`、`G1`、`Listed`、`OP`
- 投注：`獨贏`、`位置`、`連贏`、`二重彩`、`三重彩`、`Wide`、`Trio`
- 場地：`芝`、`ダート`、`Firm`、`Yielding`、`Muddy`、`Sloppy`
- 分析：`逃げ`、`先行`、`差し`、`追込`、`末脚`、`上がり`、`折合`
- 馬名：`Almond Eye`、`Contrail`、`Deep Impact`、`Equinox`

## 維護原則

- 詳細來源 URL 集中放在 `references/source-policy.md`。
- 分類詞條表格欄位固定，不在表格內塞入長篇註解。
- 維基百科只能補背景，不單獨決定主譯名。
- 使用者要求翻譯校正由使用者處理時，可收錄候選詞，但 `譯名狀態` 與 `來源等級` 不得誇大。
- 馬名不得依地區、賽事或年代另開分檔；`horses/horses.md` 是唯一馬名 canonical 檔。
- agent 蒐集資料後，新增或修改前必須再查重一次；寫入後必須執行一致性驗證。
