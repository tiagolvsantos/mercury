$configs = Get-Content "configs\config_file.json" | ConvertFrom-Json

if([string]::IsNullOrEmpty($configs.financialmodelingprep_token)){
    Write-Host "Please make sure you configured your financialmodelingprep_token on configs/config_file.json" -ForegroundColor DarkMagenta
    exit 0
}

if([string]::IsNullOrEmpty($configs.finnhub_token)){
    Write-Host "Please make sure you configured your finnhub_token on configs/config_file.json" -ForegroundColor DarkMagenta
    exit 0
}

.\menu.ps1 $configs

