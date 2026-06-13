param(
  [string]$Query,
  [string]$InputPath,
  [switch]$Detailed
)

$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($Query) -and [string]::IsNullOrWhiteSpace($InputPath)) {
  throw '請提供 -Query "候選詞" 或 -InputPath 候選清單檔案。'
}

if (-not [string]::IsNullOrWhiteSpace($Query) -and -not [string]::IsNullOrWhiteSpace($InputPath)) {
  throw '請擇一使用 -Query 或 -InputPath，不要同時提供。'
}

$files = @(
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

function Find-RacingEntry {
  param(
    [Parameter(Mandatory = $true)]
    [string]$SearchText
  )

  $escaped = [regex]::Escape($SearchText)
  $foundEntries = @()

  foreach ($file in $files) {
    if (-not (Test-Path -LiteralPath $file)) {
      Write-Warning "找不到檔案：$file"
      continue
    }

    $lineNumber = 0
    foreach ($line in Get-Content -Encoding UTF8 -LiteralPath $file) {
      $lineNumber++
      if ($line -notmatch '^\|\s*[A-Z]+-\d{3,}\s*\|') {
        continue
      }

      if ($line -match $escaped) {
        $foundEntries += [pscustomobject]@{
          File = $file
          Line = $lineNumber
          Entry = $line
        }
      }
    }
  }

  return $foundEntries
}

function Write-QueryResult {
  param(
    [Parameter(Mandatory = $true)]
    [string]$SearchText,
    [switch]$ShowDetails
  )

  $foundEntries = @(Find-RacingEntry -SearchText $SearchText)

  if ($foundEntries.Count -eq 0) {
    Write-Output "NO_MATCH query=$SearchText"
    return
  }

  Write-Output "MATCH query=$SearchText count=$($foundEntries.Count)"
  if ($ShowDetails) {
    $foundEntries | ForEach-Object {
      Write-Output "$($_.File):$($_.Line): $($_.Entry)"
    }
  }
}

if (-not [string]::IsNullOrWhiteSpace($Query)) {
  Write-QueryResult -SearchText $Query -ShowDetails:$Detailed.IsPresent
  exit 0
}

if (-not (Test-Path -LiteralPath $InputPath)) {
  throw "找不到候選清單檔案：$InputPath"
}

$queries = Get-Content -Encoding UTF8 -LiteralPath $InputPath |
  ForEach-Object { $_.Trim() } |
  Where-Object { $_ -and -not $_.StartsWith('#') }

foreach ($candidate in $queries) {
  Write-QueryResult -SearchText $candidate -ShowDetails:$Detailed.IsPresent
}
