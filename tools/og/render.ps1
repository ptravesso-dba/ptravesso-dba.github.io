# Gera assets/og.png (1200x630) e assets/apple-touch-icon.png (180x180) com o Edge sem janela.
# Uso: powershell -File tools/og/render.ps1
$ErrorActionPreference = 'Continue'  # o Edge escreve avisos no stderr
$root = Resolve-Path (Join-Path $PSScriptRoot '..\..')
$edge = 'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe'
$profileDir = Join-Path $env:TEMP 'ptravesso-og-render'

function Shot($page, $out, $w, $h) {
  $url = 'file:///' + ((Join-Path $PSScriptRoot $page) -replace '\\', '/')
  $dest = Join-Path $root $out
  & $edge --headless=new --disable-gpu --hide-scrollbars --allow-file-access-from-files `
    "--user-data-dir=$profileDir" "--window-size=$w,$h" --virtual-time-budget=8000 `
    "--screenshot=$dest" $url 2>$null | Out-Null
  Start-Sleep -Milliseconds 500
  if (-not (Test-Path $dest)) { throw "nao gerou $out" }
  Write-Output ("{0}: {1} bytes" -f $out, (Get-Item $dest).Length)
}

Shot 'og.html'   'assets\og.png'               1200 630
Shot 'icon.html' 'assets\apple-touch-icon.png' 180  180
