# horses.md fact-check report 2026-06-13

本報告彙整 `docs/racing-language/horses/horses.md` 逐筆 fact-check 結果。審查由 5 個 fact-checker 依 ID 區間並行完成，範圍涵蓋目前 `horses.md` 的 1092 筆馬名列。

## 審查範圍

| 區間 | 結果摘要 |
|---|---|
| H-0001..H-0249 | 發現多筆勝績、年份、血統與狀態錯配。 |
| H-0250..H-0499 | 發現多筆勝績錯配、英文名錯配、重複 canonical 與現役狀態錯誤。 |
| H-0500..H-0749 | 發現多筆勝績錯配、性別錯誤、重複 canonical 與退役狀態錯誤。 |
| H-0750..H-0999 | 發現多筆錯名、重複 canonical、賽事勝績錯配與來源等級風險。 |
| H-1000..H-1097 | 發現多筆英文名、出生年、代表勝績與現役/退役狀態錯誤。 |

## 整體結論

- 本輪未再發現大量人物、賽事、賽道或機構混入 `horses.md`；前一輪已移除 `Bart Cummings`、`Caulfield Cup`、`Darby Munro`、`Winx Club`、`Royal Ascot`。
- `horses.md` 仍存在大量內容品質問題，主要是勝績錯配、年份錯配、血統錯配、現役/退役狀態錯誤、英文/日文名錯配、重複 canonical。
- 多筆 `官方/A` 目前缺乏高可信中文來源支撐，可能把日文/英文官方資料誤當成「官方中文譯名」。
- 多筆 `詳細確認要` 或 `補完用` 仍留在正式 canonical 表內；即使標為 `D/需確認`，也會降低資料庫可用性。

## 高優先級修正清單

以下為 subagent 判定的高優先級問題。這些列應優先修正、合併或降級為待確認候選。

### H-0001..H-0249

| ID | 問題類型 | 摘要 |
|---|---|---|
| H-0052 | 勝績錯配 | Arabian Knight 未勝 2023 Breeders' Cup Dirt Mile，主要 G1 為 2023 Pacific Classic。 |
| H-0071 | 戰績/G1 數錯 | Baaeed 非全勝，Champion Stakes 落敗；G1×9 過高。 |
| H-0079 | 勝績錯配 | Bathrat Leon 未勝 NHK Mile Cup。 |
| H-0080 | 勝績錯配 | Battle of Marengo 未勝 2016 Dubai Sheema Classic。 |
| H-0097 | 年代/勝績錯 | Biko Pegasus 非 1980 年代馬，未勝有馬記念。 |
| H-0128 | 血統/勝績錯 | Cacique 是 Danehill 產駒，非 Galileo；勝績也錯。 |
| H-0130 | 勝績錯配 | Cafe Pharoah 主要勝績為 February Stakes，不是 UAE Derby/BC Dirt Mile。 |
| H-0149 | 勝績錯配 | Chablis 未勝 2019 Hanshin Juvenile Fillies。 |
| H-0155 | 勝績錯配 | Cheshire 未勝 2000 Guineas。 |
| H-0162 | 勝績錯配 | City of Troy 未勝 2024 2000 Guineas。 |
| H-0168 | 勝績錯配 | Cody's Wish 未勝 Pegasus World Cup，代表為 BC Dirt Mile。 |
| H-0181 | 勝績/國別錯 | Country Grammer 勝 2022 Dubai World Cup，不是 Saudi Cup；非日本競走馬。 |
| H-0185 | 對手錯 | Creator 2016 Belmont Stakes 擊敗 Destin，不是 Frosted。 |
| H-0191 | 名稱錯配 | Curren Bouquard 疑應為 Curren Bouquetd'or / カレンブーケドール。 |
| H-0193 | 勝績錯配 | Cyberknife 未勝 2022 BC Dirt Mile。 |
| H-0195 | 勝績錯配 | Dahlia 未勝凱旋門賞。 |
| H-0207 | 勝績錯配 | Danon Beluga 未勝天皇賞秋。 |
| H-0223 | 勝績錯配 | Derma Sotogake 勝 2023 UAE Derby，不是 Dubai World Cup。 |
| H-0224 | 調教師/血統錯 | Desert Crown 調教師與父系錯。 |
| H-0228 | 勝績/G1 數錯 | Do Deuce 2024 有馬記念未出走；G1 數應重算。 |
| H-0229 | 名次錯 | Dolniya 是 2015 Dubai Sheema Classic 優勝，不是亞軍。 |
| H-0243 | 年份/勝績錯 | Earthlight G1 勝績為 2019 兩歲 G1，非 2020 多項 G1。 |

### H-0250..H-0499

| ID | 問題類型 | 摘要 |
|---|---|---|
| H-0251 | 調教師錯 | Electrocutionist 2006 Dubai World Cup 時為 Saeed bin Suroor 調教。 |
| H-0260 | 勝績/調教師錯 | Epicenter 未勝 Preakness；調教師是 Steve Asmussen。 |
| H-0261 | G1 數/rating 錯 | Equinox G1 勝為 6；世界評分非 140。 |
| H-0272 | 勝績錯配 | Fastnet Rock 未勝 Golden Rose。 |
| H-0291 | 年份錯 | Forte 的 Breeders' Cup Juvenile 勝績是 2022。 |
| H-0303 | 血統/勝績錯 | Sea The Stars 不是 Galileo 子嗣。 |
| H-0313 | 名稱錯配 | Geraldo Barows 應為 Geraldina / ジェラルディーナ。 |
| H-0336 | 勝績錯配 | Gronkowski 未勝 Dubai Golden Shaheen。 |
| H-0340 | 名稱錯配 | Hakata Ichi Ban 與 ハナズゴール / Hana's Goal 錯配。 |
| H-0353 | 勝績錯配 | Hawk Wing 未勝 2002 2000 Guineas。 |
| H-0361 | G1 數錯 | Hermosa G1×4 可疑，主要為英/愛 1000 Guineas。 |
| H-0365 | 重複 canonical | High-Rise 與 H-0364 High Rise 重複。 |
| H-0379 | 勝績錯配 | Hurricane Lane 未勝 Dubai Sheema Classic。 |
| H-0385 | 疑似錯馬 | Ile de France 的 2022 BC Mile 勝績高度可疑。 |
| H-0390 | 勝績錯配 | Inspiral 未勝英 1000 Guineas。 |
| H-0395 | 勝績錯配 | Jack d'Or 未勝天皇賞秋。 |
| H-0400 | 馬主錯 | Jazil 非 Godolphin 馬。 |
| H-0414 | 勝績/狀態錯 | Justin Palace 未勝天皇賞秋，且已退役入種。 |
| H-0418 | 勝績錯配 | Karar 未勝 2024 Dubai Sheema Classic。 |
| H-0425 | 國別/性別錯 | Kensei 是紐西蘭產澳洲訓練 gelding，非日本雄馬。 |
| H-0436 | 血統錯 | Sol Oriens 父為 Kitasan Black，不是 Kizuna。 |
| H-0455 | 國別/勝績錯 | Laurens 非法國訓練，且非 2019 Dubai Turf 亞軍。 |
| H-0457 | 勝績/子嗣錯 | Le Havre 勝 Prix du Jockey Club；Zarak 不是其子嗣。 |
| H-0463 | 狀態錯 | Lemon Pop 已退役並在 Darley Japan 配種。 |
| H-0466 | 產地/勝績錯 | Letruska 非烏克蘭產，未勝 BC Filly & Mare Sprint。 |
| H-0468 | 狀態錯 | Liberty Island 已於 2025-04-27 香港 QEII Cup 後死亡。 |
| H-0469 | 馬主錯 | Life Is Good 非 Godolphin 所有。 |
| H-0473 | 名稱/血統錯 | Lismo 應為 Lys Gracieux；父為 Heart's Cry。 |
| H-0474 | 名稱錯配 | Logi Caviano 應為 Logi Cry。 |
| H-0489 | 勝績錯配 | Magic Wand 未勝 2019 Dubai Sheema Classic。 |
| H-0493 | 性別錯 | Mairzy Doates 是雌馬。 |
| H-0499 | 年份錯 | Malathaat 的 BC Distaff 勝績為 2022。 |

### H-0500..H-0749

| ID | 問題類型 | 摘要 |
|---|---|---|
| H-0514 | 香港紀錄/血統錯 | Maurice 香港為 3 戰 3 勝；非 Pilsudski 系。 |
| H-0516 | 勝績錯配 | Maximum Security 未勝 BC Dirt Mile。 |
| H-0525 | 勝績錯 | Mejiro McQueen 是天皇賞春連霸，非三連霸。 |
| H-0529 | 勝績錯配 | Midnight Bisou 2019 BC Distaff 為第 2。 |
| H-0553 | 血統錯 | Montjeu 不是 Galileo 父。 |
| H-0575 | 勝績錯配 | Namur 未勝 Victoria Mile。 |
| H-0602 | 勝績錯配 | North America 未勝 2015 Dubai Sheema Classic。 |
| H-0616 | 年份錯 | Old Persian 勝 2019 Dubai Sheema Classic。 |
| H-0622 | 勝績錯配 | Opera Singer 未勝 2024 1000 Guineas/Oaks。 |
| H-0623 | 英文錯 | オラトリオ 應對應 Oratorio，不是 Oratorical。 |
| H-0627 | G1 數/勝績錯 | Paddington 未勝 Irish Champion Stakes，G1 應為 4。 |
| H-0630 | G1 數錯 | Palace Pier 應為 G1×5。 |
| H-0660 | 勝利描述錯 | Qualify 是爆冷險勝，不是大比數。 |
| H-0663 | G1 數錯 | Quorto 主要 G1 為 National Stakes。 |
| H-0665 | 調教師錯 | Rags to Riches 調教師是 Todd Pletcher。 |
| H-0668 | 性別錯 | Rainbow Line 是雄馬/種牡馬，不是雌馬。 |
| H-0672 | 名稱錯配 | Ray della Stella / レイデルアストレア 疑似錯配。 |
| H-0677 | 勝績/狀態錯 | Rebel's Romance 有多項 G1，且未確認退役。 |
| H-0692 | 勝績錯配 | Resplandor 未勝 2005 Dubai Golden Shaheen。 |
| H-0697 | 勝績錯配 | Right on Cue 未勝 2014 Dubai Golden Shaheen。 |
| H-0701 | 勝績錯配 | Roaring Lion 未勝 2018 Champion Stakes。 |
| H-0705 | 勝績錯配 | Roman Empire 未勝 2024 St Leger。 |
| H-0732 | 血統錯 | Saturnalia 父為 Lord Kanaloa，不是 Deep Impact。 |
| H-0737 | 勝績/狀態錯 | Schnell Meister 未勝 Yasuda Kinen，且已退役入種。 |
| H-0740/H-0745 | 重複 canonical | Sea Bird 與 Sea-Bird 是同一馬。 |
| H-0741 | 馬主錯 | Sea Hero 非日本人馬主所有。 |

### H-0750..H-0999

| ID | 問題類型 | 摘要 |
|---|---|---|
| H-0763 | 名稱錯配 | Shiboruto 與 ジョワドヴィーヴル / Joie de Vivre 錯配。 |
| H-0801 | 勝績錯配 | Sodashi 未勝 February Stakes。 |
| H-0809/H-0802 | 重複/英文/血統錯 | Soul Orientale 應為 Sol Oriens，且與 H-0802 重複；父為 Kitasan Black。 |
| H-0812 | 狀態/勝績漏 | Sovereignty 仍屬現役語境，且勝 2025 Belmont Stakes。 |
| H-0820 | 血統錯 | Verry Elleegant 父為 Zed，不是 Spirit of Boom。 |
| H-0822 | 勝績/日文錯 | St Nicholas Abbey 未勝 Cox Plate；日文欄錯。 |
| H-0825 | 日文/勝績錯 | Staphanos 日文應為 ステファノス，未勝香港マイルC。 |
| H-0833 | 草稿殘留/勝績錯 | Straight Girl 定義含 `Wait...`，Sprinters Stakes 僅 2015 優勝。 |
| H-0851 | 英文/G1 數錯 | Suzuka Phoenix 拼寫錯，G1 勝為一項。 |
| H-0856 | 對手錯 | Swiss Skydiver Preakness 對手是 Authentic。 |
| H-0857/H-0858 | 重複 canonical | Symboli Chris S / Symboli Kris S 同一馬。 |
| H-0862 | 調教師錯 | Tabasco Cat 由 D. Wayne Lukas 訓練。 |
| H-0868 | 勝績/距離錯 | Taisei Vision 未勝 NHK Mile Cup，非中距離馬。 |
| H-0869 | 名稱錯配 | Takashi Sanei 應為 Takara Steal。 |
| H-0876 | 勝績錯配 | Tapit Trice 未勝 2023 Belmont Stakes。 |
| H-0882/H-0861 | 重複 canonical | Teiyo Opera O 與 T.M. Opera O 同一馬。 |
| H-0884/H-0860 | 重複 canonical | Teo Royal 與 T O Royal 同一馬。 |
| H-0897 | 勝績錯配 | Toast of New York 未勝 BC Dirt Mile。 |
| H-0904 | 名稱錯配 | Tosho Knight 與 トーショウボーイ / Tosho Boy 錯配。 |
| H-0912 | 勝績錯配 | Tuesday 未勝 2022 Irish Oaks。 |
| H-0928 | 勝績錯配 | Vauban 未勝 2023 Melbourne Cup。 |
| H-0949 | 疑似非目標馬 | Werthers Original 高機率應為 Werther 或品牌誤入。 |
| H-0954 | 狀態/勝績錯 | White Abarrio 2023 BC Classic 是優勝，不是 2 着；退役狀態需確認。 |
| H-0955 | 勝績錯配 | Wild Illusion 未勝 Dubai Turf。 |
| H-0973 | 勝績錯配 | Yoshida 未勝 Dubai Turf。 |
| H-0995 | 英文/G1 數錯 | Eihin Flash 應為 Eishin Flash，G1 勝為 2。 |
| H-0996 | 勝績錯配 | Omega Perfume 未勝 Champions Cup。 |
| H-0999 | G1 數錯 | Kawakami Princess 應為 G1×2，エリザベス女王杯為降著。 |

### H-1000..H-1097

| ID | 問題類型 | 摘要 |
|---|---|---|
| H-1002 | 勝績錯配 | Queen Spumante 主勝為 2009 エリザベス女王杯，不是天皇賞春。 |
| H-1012 | 英文/勝績錯 | Copano Ricky 應為 Copano Rickey；JBC スプリント勝績錯。 |
| H-1013 | 勝績錯配 | Sound True 未勝帝王賞。 |
| H-1024 | 生年/勝績錯 | Ski Captain 1992 年生，主勝為 1995 きさらぎ賞。 |
| H-1031 | 英文/分類/勝績錯 | Centelleo 是芝馬，非ダート名馬，也未勝 JBC Ladies' Classic。 |
| H-1037 | 勝績錯 | Chuck Naito 主勝為 2024 AJCC；有馬記念 2 着未確認。 |
| H-1039 | 英文/狀態錯 | T O Keynes 已退役入種，不是現役；英文名錯。 |
| H-1045 | 子嗣錯 | El Condor Pasa 父為 Kingmambo，不是 Tony Bin。 |
| H-1046 | 英文/生年/年份錯 | Narita Taishin，1990 年生，1993 皐月賞。 |
| H-1054 | 勝績錯配 | Nonko no Yume 未確認 JBC Sprint 優勝。 |
| H-1061 | 勝績錯配 | Hishi Akebono 代表 G1 為 Sprinters Stakes，不是高松宮記念。 |
| H-1066 | G1 數錯 | Fine Motion 應為 G1×2。 |
| H-1067 | 勝績錯配 | Falbrav 未勝安田記念。 |
| H-1069 | 生年/勝績錯 | Fusaichi Concorde 1993 年生，1996 東京優駿優勝。 |
| H-1074 | 勝績錯配 | Prognosis 未勝 G1，主為 G2 勝與 G1 入著。 |
| H-1076 | 勝績錯配 | Pop Rock 未勝天皇賞春，主勝為目黒記念。 |
| H-1080 | 英文/生年錯 | ミューチャリー 英文應核為 Mutually，2016 年生。 |
| H-1090 | 英文/勝績錯 | リオンディーズ 應為 Leontes，勝朝日杯 FS，不是阪神 JF。 |

## 重複 canonical 候選

| 保留建議 | 合併/移除候選 | 理由 |
|---|---|---|
| H-0364 High Rise | H-0365 High-Rise | 同一匹 1998 Epsom Derby 勝馬。 |
| H-0740 或 H-0745 | H-0740/H-0745 其一 | Sea Bird / Sea-Bird / Sea Bird II 同一馬。 |
| H-0802 Sol Oriens | H-0809 Soul Orientale | 同一馬，H-0809 英文與血統錯。 |
| H-0858 Symboli Kris S | H-0857 Symboli Chris S | 同一馬，英文拼寫應採 Symboli Kris S。 |
| H-0861 T.M. Opera O | H-0882 Teiyo Opera O | 同一馬。 |
| H-0860 T O Royal | H-0884 Teo Royal | 同一馬。 |

## 占位或資訊不足詞條

以下列不是全部錯誤，但目前資訊不足，不適合作為可信 canonical 詞條使用；應補來源或移到候選清單。

`H-0105`, `H-0165`, `H-0177`, `H-0201`, `H-0216`, `H-0226`, `H-0238`, `H-0280`, `H-0332`, `H-0370`, `H-0427`, `H-0517`, `H-0557`, `H-0573`, `H-0584`, `H-0773`, `H-0777`, `H-0785`, `H-0848`, `H-0908`, `H-0949`, `H-0970`, `H-0993`, `H-1023`, `H-1068`, `H-1075`, `H-1087`

## 建議修正順序

1. 先修或刪除重複 canonical：避免同一馬兩筆資料互相污染。
2. 修正「明確錯名」列：例如 H-0191、H-0313、H-0340、H-0473、H-0763、H-0869、H-0904、H-1090。
3. 修正「勝績錯配」列：把未勝的 G1、錯年份、錯賽事先移除。
4. 修正現役/退役/死亡狀態：例如 Lemon Pop、Liberty Island、Schnell Meister、T O Keynes。
5. 集中審查 `譯名狀態=官方` 與 `來源等級=A`：沒有高可信中文來源的列應降級。
6. 處理占位列：補來源，或移出正式 canonical 表。

## 後續驗證

每批修正後應執行：

```powershell
./scripts/validate-racing-language.ps1
```

並針對修正 ID 使用：

```powershell
./scripts/check-racing-entry.ps1 -Query "馬名" -Detailed
```

