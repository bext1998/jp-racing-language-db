param(
  [switch]$Strict
)

$ErrorActionPreference = 'Stop'

$horseFile = 'docs/racing-language/horses/horses.md'
$entryFiles = @(
  'docs/racing-language/terms/basic-racing.md',
  'docs/racing-language/terms/breeding-bloodlines.md',
  'docs/racing-language/terms/global-racing-terms.md',
  'docs/racing-language/terms/japanese-racing-system.md',
  'docs/racing-language/terms/jra-g1-races.md',
  'docs/racing-language/terms/jumps-racing.md',
  'docs/racing-language/terms/race-analysis.md',
  'docs/racing-language/terms/racing-equipment.md',
  'docs/racing-language/people/racing-people.md'
)

if (-not (Test-Path -LiteralPath $horseFile)) {
  throw "找不到馬名檔：$horseFile"
}

function Get-RacingEntries {
  param([Parameter(Mandatory = $true)][string]$Path)

  $entries = @()
  $lineNumber = 0
  foreach ($line in Get-Content -Encoding UTF8 -LiteralPath $Path) {
    $lineNumber++
    if ($line -notmatch '^\|\s*[A-Z]+-\d{3,}\s*\|') {
      continue
    }

    $cols = $line.Trim('|').Split('|') | ForEach-Object { $_.Trim() }
    if ($cols.Count -ne 10) {
      continue
    }

    $entries += [pscustomobject]@{
      File = $Path
      Line = $lineNumber
      ID = $cols[0]
      Name = $cols[1]
      Japanese = $cols[2]
      English = $cols[3]
      Category = $cols[4]
      Definition = $cols[5]
      Context = $cols[6]
      Related = $cols[7]
      Status = $cols[8]
      Source = $cols[9]
      Raw = $line
    }
  }

  return $entries
}

function Normalize-EntryKey {
  param([string]$Text)

  if ([string]::IsNullOrWhiteSpace($Text) -or $Text.Trim() -eq '—') {
    return ''
  }

  return ($Text.Trim().ToLowerInvariant() -replace '[‘’]', '''' -replace '\s+', ' ')
}

$horseEntries = @(Get-RacingEntries -Path $horseFile)
$otherByName = @{}
$otherByEnglish = @{}

foreach ($file in $entryFiles) {
  if (-not (Test-Path -LiteralPath $file)) {
    continue
  }

  foreach ($entry in Get-RacingEntries -Path $file) {
    $nameKey = Normalize-EntryKey $entry.Name
    $englishKey = Normalize-EntryKey $entry.English

    if ($nameKey) {
      if (-not $otherByName.ContainsKey($nameKey)) {
        $otherByName[$nameKey] = @()
      }
      $otherByName[$nameKey] += $entry
    }

    if ($englishKey) {
      if (-not $otherByEnglish.ContainsKey($englishKey)) {
        $otherByEnglish[$englishKey] = @()
      }
      $otherByEnglish[$englishKey] += $entry
    }
  }
}

$errors = @()
$warnings = @()

$allowedHorseCategoryPattern = '馬|種牡馬|種馬|牝馬|現役|繁殖|名馬|ダート'
$eventNamePattern = '(?i)\b(Cup|Stakes|Derby|Oaks|Guineas|Plate|Prix|National|Classic|Championship|Trophy|Mile|Sprint|Race)\b'
$venueOrgNamePattern = '(?i)\b(Racecourse|Racing Club|Club|Association|Authority|Federation|Farm|Stud|Stable|Park|Downs)\b'
$eventDefinitionPattern = '賽事|重賞|每年.*舉行|於.*賽馬場.*舉行|距離\s*[0-9]+|前哨賽|紀念賽事|比賽'
$nonHorseDefinitionStartPattern = '^(.*退役)?(騎師|騎手|調教師|練馬師|馬主|育馬者|賽馬場|競馬場|機構|組織|賽事|賽道)'
$explicitNonHorsePattern = '非指.*(本馬|馬)|不是.*馬|紀念賽事'

foreach ($entry in $horseEntries) {
  if ($entry.Category -notmatch $allowedHorseCategoryPattern) {
    $errors += "$($entry.File):$($entry.Line): $($entry.ID) 馬名檔分類疑似非馬匹：$($entry.Category)"
  }

  if ($entry.Definition -match $nonHorseDefinitionStartPattern) {
    $errors += "$($entry.File):$($entry.Line): $($entry.ID) 定義主詞疑似非馬匹：$($entry.Definition)"
  }

  if ($entry.Definition -match $explicitNonHorsePattern) {
    $errors += "$($entry.File):$($entry.Line): $($entry.ID) 定義明確排除馬匹主體：$($entry.Definition)"
  }

  $nameLooksLikeEvent = $entry.Name -match $eventNamePattern -or $entry.English -match $eventNamePattern
  $nameLooksLikeVenueOrOrg = $entry.Name -match $venueOrgNamePattern -or $entry.English -match $venueOrgNamePattern
  $definitionLooksLikeEvent = $entry.Definition -match $eventDefinitionPattern

  if ($nameLooksLikeEvent -and $definitionLooksLikeEvent) {
    $errors += "$($entry.File):$($entry.Line): $($entry.ID) 主名稱與定義疑似賽事而非馬名：$($entry.Name) / $($entry.English)"
  } elseif ($nameLooksLikeEvent -or $nameLooksLikeVenueOrOrg) {
    $warnings += "$($entry.File):$($entry.Line): $($entry.ID) 主名稱含高風險詞，需人工確認：$($entry.Name) / $($entry.English)"
  }

  $keysToCheck = @(
    [pscustomobject]@{ Kind = '主譯名'; Key = Normalize-EntryKey $entry.Name },
    [pscustomobject]@{ Kind = '英文名'; Key = Normalize-EntryKey $entry.English }
  )

  foreach ($keyInfo in $keysToCheck) {
    if (-not $keyInfo.Key) {
      continue
    }

    $matches = @()
    if ($keyInfo.Kind -eq '主譯名' -and $otherByName.ContainsKey($keyInfo.Key)) {
      $matches = @($otherByName[$keyInfo.Key])
    } elseif ($keyInfo.Kind -eq '英文名' -and $otherByEnglish.ContainsKey($keyInfo.Key)) {
      $matches = @($otherByEnglish[$keyInfo.Key])
    }

    foreach ($match in $matches) {
      if ($match.Category -match $allowedHorseCategoryPattern) {
        $warnings += "$($entry.File):$($entry.Line): $($entry.ID) $($keyInfo.Kind) 與其他檔案馬名類詞條重複：$($match.File):$($match.Line) $($match.ID)"
      } else {
        $warnings += "$($entry.File):$($entry.Line): $($entry.ID) $($keyInfo.Kind) 與非馬名詞條同名，需確認責任邊界：$($match.File):$($match.Line) $($match.ID) [$($match.Category)]"
      }
    }
  }
}

if ($warnings.Count) {
  Write-Output 'WARNINGS:'
  $warnings | Sort-Object -Unique | ForEach-Object { Write-Output $_ }
}

if ($errors.Count) {
  Write-Output 'ERRORS:'
  $errors | Sort-Object -Unique | ForEach-Object { Write-Output $_ }
  exit 1
}

if ($Strict -and $warnings.Count) {
  exit 1
}

Write-Output "OK horse_scope entries=$($horseEntries.Count) warnings=$($warnings.Count)"
