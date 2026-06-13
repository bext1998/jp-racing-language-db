param(
  [switch]$Strict
)

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

function Get-ExpectedScope {
  param([string]$File)

  switch -Regex ($File) {
    'horses/horses\.md$' { return 'horse' }
    'people/racing-people\.md$' { return 'person' }
    'terms/racing-equipment\.md$' { return 'equipment' }
    default { return 'term' }
  }
}

$entries = @()
foreach ($file in $entryFiles) {
  if (-not (Test-Path -LiteralPath $file)) {
    throw "找不到詞條檔：$file"
  }

  $entries += Get-RacingEntries -Path $file
}

$errors = @()
$warnings = @()

$horseCategoryPattern = '馬|種牡馬|種馬|牝馬|現役|繁殖|名馬|ダート'
$personCategoryPattern = '騎師|騎手|調教師|練馬師|馬主|育馬者|人物|關係人'
$equipmentCategoryPattern = '馬具|裝備|配件|ブリンカー|メンコ|シャドーロール'
$eventCategoryPattern = '賽事|競走|G1|G2|G3|重賞|經典賽|賽事節'
$venueOrgCategoryPattern = '賽道|賽馬場|競馬場|機構|組織|馬主機構|俱樂部'
$personCategoryStrictPattern = '^(騎師|騎手|調教師|練馬師|馬主|育馬者|人物|關係人)$'
$eventCategoryStrictPattern = '^(賽事|競走|G1|G2|G3|重賞|經典賽|賽事節)$'
$venueOrgCategoryStrictPattern = '^(賽道|賽馬場|競馬場|機構|組織|馬主機構|俱樂部)$'
$eventNamePattern = '(?i)\b(Cup|Stakes|Derby|Oaks|Guineas|Plate|Prix|National|Classic|Championship|Trophy)\b'
$nonHorseDefinitionStartPattern = '^(.*退役)?(騎師|騎手|調教師|練馬師|馬主|育馬者|賽馬場|競馬場|機構|組織|賽事|賽道)'

foreach ($entry in $entries) {
  $scope = Get-ExpectedScope -File $entry.File

  if ($scope -eq 'horse') {
    if ($entry.Category -notmatch $horseCategoryPattern) {
      $errors += "$($entry.File):$($entry.Line): $($entry.ID) 馬名檔分類錯置：$($entry.Category)"
    }
    if ($entry.Definition -match $nonHorseDefinitionStartPattern) {
      $errors += "$($entry.File):$($entry.Line): $($entry.ID) 馬名檔定義主詞疑似非馬匹：$($entry.Definition)"
    }
    if (($entry.Name -match $eventNamePattern -or $entry.English -match $eventNamePattern) -and $entry.Definition -match '賽事|重賞|每年.*舉行|紀念賽事|前哨賽') {
      $errors += "$($entry.File):$($entry.Line): $($entry.ID) 馬名檔疑似收錄賽事：$($entry.Name) / $($entry.English)"
    }
  } elseif ($scope -eq 'person') {
    if ($entry.Category -notmatch $personCategoryPattern) {
      $warnings += "$($entry.File):$($entry.Line): $($entry.ID) 人物檔分類需確認：$($entry.Category)"
    }
  } elseif ($scope -eq 'equipment') {
    if ($entry.Category -match $personCategoryStrictPattern -or $entry.Category -match $eventCategoryStrictPattern -or $entry.Category -match $venueOrgCategoryStrictPattern) {
      $warnings += "$($entry.File):$($entry.Line): $($entry.ID) 裝備檔分類需確認：$($entry.Category)"
    }
  } else {
    if ($entry.Category -eq '馬名') {
      $warnings += "$($entry.File):$($entry.Line): $($entry.ID) 術語檔含馬名分類，需確認是否應移至 horses.md"
    }
    if ($entry.Category -match $personCategoryPattern) {
      $warnings += "$($entry.File):$($entry.Line): $($entry.ID) 術語檔含人物分類，需確認是否應移至 people/racing-people.md"
    }
  }
}

$byName = @{}
$byEnglish = @{}
foreach ($entry in $entries) {
  foreach ($keyInfo in @(
    [pscustomobject]@{ Kind = '主譯名'; Key = Normalize-EntryKey $entry.Name; Map = $byName },
    [pscustomobject]@{ Kind = '英文名'; Key = Normalize-EntryKey $entry.English; Map = $byEnglish }
  )) {
    if (-not $keyInfo.Key) {
      continue
    }

    if (-not $keyInfo.Map.ContainsKey($keyInfo.Key)) {
      $keyInfo.Map[$keyInfo.Key] = @()
    }
    $keyInfo.Map[$keyInfo.Key] += $entry
  }
}

foreach ($mapInfo in @(
  [pscustomobject]@{ Kind = '主譯名'; Map = $byName },
  [pscustomobject]@{ Kind = '英文名'; Map = $byEnglish }
)) {
  foreach ($key in $mapInfo.Map.Keys) {
    $matches = @($mapInfo.Map[$key])
    if ($matches.Count -lt 2) {
      continue
    }

    $scopes = @($matches | ForEach-Object { Get-ExpectedScope -File $_.File } | Sort-Object -Unique)
    if ($scopes.Count -lt 2) {
      continue
    }

    if ($scopes -notcontains 'horse' -and $scopes -notcontains 'person') {
      continue
    }

    $summary = ($matches | ForEach-Object { "$($_.File):$($_.Line) $($_.ID) [$($_.Category)]" }) -join '; '
    $warnings += "跨檔同名需確認 $($mapInfo.Kind)='$key': $summary"
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

Write-Output "OK racing_scope entries=$($entries.Count) warnings=$($warnings.Count)"
