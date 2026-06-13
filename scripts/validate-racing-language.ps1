$ErrorActionPreference = 'Stop'

$entryFiles = @(
  'docs/racing-language/terms/basic-racing.md',
  'docs/racing-language/terms/breeding-bloodlines.md',
  'docs/racing-language/terms/global-racing-terms.md',
  'docs/racing-language/terms/japanese-racing-system.md',
  'docs/racing-language/terms/jra-g1-races.md',
  'docs/racing-language/terms/jumps-racing.md',
  'docs/racing-language/terms/race-analysis.md',
  'docs/racing-language/terms/racing-equipment.md',
  'docs/racing-language/horses/horses.md',
  'docs/racing-language/people/racing-people.md'
)

$referenceFiles = @(
  'docs/racing-language/references/source-policy.md',
  'docs/racing-language/references/glossary-style.md'
)

$retiredHorseFiles = @(
  'docs/racing-language/horses/australian-horses.md',
  'docs/racing-language/horses/dubai-horses.md',
  'docs/racing-language/horses/european-horses.md',
  'docs/racing-language/horses/international-horses.md',
  'docs/racing-language/horses/jra-g1-winners.md',
  'docs/racing-language/horses/notable-horses.md',
  'docs/racing-language/horses/notable-sires.md',
  'docs/racing-language/horses/uk-classic-winners.md',
  'docs/racing-language/horses/us-racing-horses.md'
)

$ids = @{}
$bad = @()
$allowedStatus = @('官方', '常用', '暫定', '需確認')
$allowedSource = @('A', 'B', 'C', 'D')
$horseNames = @{}
$horseEnglish = @{}

function Normalize-EntryKey {
  param([string]$Text)

  if ([string]::IsNullOrWhiteSpace($Text) -or $Text.Trim() -eq '—') {
    return ''
  }

  return ($Text.Trim().ToLowerInvariant() -replace "[‘’]", "’" -replace ‘\s+’, ‘ ‘)
}

foreach ($file in $entryFiles) {
  if (-not (Test-Path -LiteralPath $file)) {
    $bad += "找不到詞條檔：$file"
    continue
  }

  $lines = Get-Content -Encoding UTF8 -LiteralPath $file
  foreach ($line in $lines) {
    if ($line -notmatch '^\|\s*([A-Z]+)-\d{3,}\s*\|') {
      continue
    }

    $cols = $line.Trim('|').Split('|') | ForEach-Object { $_.Trim() }
    $id = $cols[0]

    if ($cols.Count -ne 10) {
      $bad += "${file}: 欄位數 $($cols.Count): $line"
      continue
    }

    if ($ids.ContainsKey($id)) {
      $bad += "重複 ID ${id}: $file 與 $($ids[$id])"
    } else {
      $ids[$id] = $file
    }

    if ($allowedStatus -notcontains $cols[8]) {
      $bad += "${file}: 非法譯名狀態 $($cols[8]) at $id"
    }

    if ($allowedSource -notcontains $cols[9]) {
      $bad += "${file}: 非法來源等級 $($cols[9]) at $id"
    }

    if (($cols[9] -eq 'C' -or $cols[9] -eq 'D') -and ($cols[8] -eq '官方')) {
      $bad += "${file}: $id 來源 $($cols[9]) 不應標官方"
    }

    if ($line -match 'https?://') {
      $bad += "${file}: $id 詞條列不應放 URL"
    }

    if ($file -eq 'docs/racing-language/horses/horses.md') {
      if ($cols[4] -notmatch '馬|種牡馬|種馬|牝馬|現役|繁殖|名馬|ダート') {
        $bad += "${file}: $id 馬名檔不應包含分類 $($cols[4])"
      }

      $nameKey = Normalize-EntryKey $cols[1]
      if ($nameKey) {
        if ($horseNames.ContainsKey($nameKey)) {
          $bad += "馬名檔重複主譯名 $($cols[1]): $id 與 $($horseNames[$nameKey])"
        } else {
          $horseNames[$nameKey] = $id
        }
      }

      $englishKey = Normalize-EntryKey $cols[3]
      if ($englishKey) {
        if ($horseEnglish.ContainsKey($englishKey)) {
          $bad += "馬名檔重複英文名 $($cols[3]): $id 與 $($horseEnglish[$englishKey])"
        } else {
          $horseEnglish[$englishKey] = $id
        }
      }
    }
  }
}

$indexPath = 'docs/racing-language/INDEX.md'
if (-not (Test-Path -LiteralPath $indexPath)) {
  $bad += "找不到 INDEX：$indexPath"
} else {
  $index = Get-Content -Encoding UTF8 -LiteralPath $indexPath -Raw
  foreach ($path in $entryFiles + $referenceFiles) {
    $rel = $path -replace '^docs/racing-language/', ''
    if ($index -notmatch [regex]::Escape($rel)) {
      $bad += "INDEX 未指向 $rel"
    }
  }

  foreach ($path in $retiredHorseFiles) {
    $rel = $path -replace '^docs/racing-language/', ''
    if ($index -match [regex]::Escape($rel)) {
      $bad += "INDEX 不應再指向舊馬名分檔 $rel"
    }
  }
}

foreach ($path in $retiredHorseFiles) {
  if (Test-Path -LiteralPath $path) {
    $bad += "舊馬名分檔仍存在：$path"
  }
}

if ($bad.Count) {
  $bad
  exit 1
}

Write-Output "OK entries=$($ids.Count) files=$($entryFiles.Count) horses=$($horseNames.Count)"
