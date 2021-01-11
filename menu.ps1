param(
    $configs
)

# load modules    
. .\libs\finnhub_lib.ps1
. .\libs\cboe_lib.ps1
. .\libs\yahoo_lib.ps1
. .\libs\benzinga_lib.ps1
. .\libs\financialmodelingprep_lib.ps1

Write-Host '-------------------------------------- Select an option -------------------------------------------------------------------------------------' -ForegroundColor DarkYellow
Write-Host
Write-Host "1 - News on stocks ratings                         | 10 - Stock company profile "                        
Write-Host "2 - CBOE Most active equity options                | 11 - Stock daily quote"
Write-Host "3 - CBOE Most active indices options               | 12 - Stock news"
Write-Host "4 - Stock Call options                             |"
Write-Host "5 - Stock Put options                              |"
Write-Host "6 - Stock sentiment                                |"
Write-Host "7 - Stock price targets                            |"
Write-Host "8 - Stock recommendation trend                     |"
Write-Host "9 - Stock metrics                                  |"
Write-Host
Write-Host '--------------------------------------- Exit = q -----------------------------------------------------------------------------------------------' -ForegroundColor DarkYellow

$option = Read-Host 

elseif ($option -eq 1) {
    Write-Host "Daily Stock ratings for $(Get-Date)" -ForegroundColor DarkMagenta
    $result = Get-DailyRatings 
    $result | Format-Table -AutoSize 
}
elseif ($option -eq 2) {
    Get-CboeEquityOptions
}
elseif ($option -eq 3) {
    Get-CboeIndicesOptions  
}
elseif ($option -eq 4) {
    $symbol = Read-Host 'Select a symbol'
    $In_the_money = Read-Host 'Do you want all options or only in the money (itm)? [all] [itm]'

    if (($In_the_money -eq "itm") -Or ($In_the_money -eq "all")) {
        $result = Get-YahooOptionsCalls $symbol 
        Write-Host "################# Call Options for $($symbol.ToUpper()) #################" -ForegroundColor DarkGreen
        
        if ($In_the_money = "all") {
            $result | Select-Object Contract, Strike, Last_Price, Change, Percent_Change, Volume, OI, Bid, Ask, IV | Sort-Object Volume –Descending | Format-Table * -AutoSize 
        }
        else {
            $result | Where-Object { $_.ITM -eq "False" } | Sort-Object Volume –Descending | Format-Table -AutoSize 
        }
    }
    else {
        Write-Host "Please input a correct option [all] or [itm]" -ForegroundColor Darkred
        pwsh.exe .\menu.ps1
    }
}
elseif ($option -eq 5) {
    $symbol = Read-Host 'Select a symbol'
    $In_the_money = Read-Host 'Do you want all options or only in the money (itm)? [all] [itm]'

    if (($In_the_money -eq "itm") -Or ($In_the_money -eq "all")) {
        $result = Get-YahooOptionsPuts $symbol 
        Write-Host "################# Put Options for $($symbol.ToUpper()) #################"  -ForegroundColor Darkred
        if ($In_the_money = "all") {
            $result | Select-Object Contract, Strike, Last_Price, Change, Percent_Change, Volume, OI, Bid, Ask, IV | Sort-Object Volume –Descending | Format-Table * -AutoSize 
        }
        else {
            $result | Where-Object { $_.ITM -eq "False" } | Sort-Object Volume –Descending | Format-Table -AutoSize 
        }
    }
    else {
        Write-Host "Please input a correct option [all] or [itm]" -ForegroundColor Darkred
        pwsh.exe .\menu.ps1
    }
}
elseif ($option -eq 6) {
    $symbol = Read-Host 'Select the symbol'
    Write-Host
    Write-Host "<3 <3 Sentiment data for $($symbol.ToUpper()) <3 <3" -ForegroundColor DarkMagenta
    Get-SymbolSentiment $symbol.ToUpper()
}
elseif ($option -eq 7) {
    $symbol = Read-Host 'Select a symbol'
    $result = Get-SymbolPriceTargets $symbol.ToUpper()
    $result | Format-Table -AutoSize 
}
elseif ($option -eq 8) {
    $symbol = Read-Host 'Select a symbol'
    $result = Get-SymbolRecomendationTrend $symbol.ToUpper()
    $result | Format-Table -AutoSize 
}
elseif ($option -eq 9) {
    $symbol = Read-Host 'Select a symbol'
    Write-Host "Financial metrics for $($symbol.ToUpper())" -ForegroundColor DarkMagenta
    $result = Get-SymbolMetrics $symbol.ToUpper()
    $result 
}
elseif ($option -eq 10) {
    $symbol = Read-Host 'Select a symbol'
    Write-Host "Company profile for $($symbol.ToUpper())" -ForegroundColor DarkMagenta
    $result = Get-SymbolProfile $symbol.ToUpper()
    $result 
}
elseif ($option -eq 11) {
    $symbol = Read-Host 'Select a symbol'
    Write-Host "Daily quote for $($symbol.ToUpper())" -ForegroundColor DarkMagenta
    $result =  Get-SymbolQuote $symbol.ToUpper()
    $result 
}
elseif ($option -eq 12) {
    $symbol = Read-Host 'Select a symbol'
    Write-Host "News for $($symbol.ToUpper())" -ForegroundColor DarkMagenta
    $result =  Get-SymbolNews $symbol.ToUpper()
    $result | Format-Table -AutoSize 
}
elseif ($option -eq "q") {
    exit 0
}

# boot menu
Write-Host
Write-Host
pwsh.exe .\menu.ps1