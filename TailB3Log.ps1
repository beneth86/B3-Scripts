filter timestamp {"$(Get-Date -Format G): $_"}

Get-Content $env:AppData\B3-CoinV2\debug.log –Wait | Where-Object {$_ -match "blocks"} | timestamp