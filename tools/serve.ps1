# Servidor estático mínimo para pré-visualizar a página localmente (somente localhost).
param([int]$Port = 8765)
$root = Split-Path -Parent $PSScriptRoot
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$Port/")
$listener.Start()
Write-Host "Servindo $root em http://localhost:$Port/"
$types = @{ ".html"="text/html; charset=utf-8"; ".css"="text/css"; ".js"="text/javascript"; ".png"="image/png"; ".jpg"="image/jpeg"; ".jpeg"="image/jpeg"; ".svg"="image/svg+xml"; ".ico"="image/x-icon"; ".webp"="image/webp" }
while ($listener.IsListening) {
  $ctx = $listener.GetContext()
  $path = [Uri]::UnescapeDataString($ctx.Request.Url.AbsolutePath.TrimStart('/'))
  if ([string]::IsNullOrEmpty($path)) { $path = "index.html" }
  $full = [IO.Path]::GetFullPath((Join-Path $root $path))
  if ($full.StartsWith($root) -and (Test-Path $full -PathType Leaf)) {
    $bytes = [IO.File]::ReadAllBytes($full)
    $ext = [IO.Path]::GetExtension($full).ToLower()
    $ctx.Response.ContentType = $(if ($types.ContainsKey($ext)) { $types[$ext] } else { "application/octet-stream" })
    $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length)
  } else { $ctx.Response.StatusCode = 404 }
  $ctx.Response.Close()
}
