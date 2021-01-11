$configs = Get-Content "configs\config_file.json" | ConvertFrom-Json

function Get-SymbolSentiment {
    param (
        [string] $symbol
    )
    
    $reponse = Invoke-WebRequest -Uri "https://finnhub.io/api/v1/news-sentiment?symbol=$($symbol)&token=$($configs.finnhub_token)"
 
    $jsonObj = ConvertFrom-Json  $reponse.Content

    if($null -eq $jsonObj.buzz)
    {
        Write-Host
        Write-Host "Theres no data for $($symbol)" -ForegroundColor DarkRed
        return 
    }else {
        $returnObject =  [PSCustomObject]@{
            Symbol = $jsonObj.symbol
            'News Score' = $jsonObj.companyNewsScore
            'Articles this week' = $jsonObj.buzz.articlesInLastWeek
            'Weekly Average' = $jsonObj.buzz.weeklyAverage
            'Buzz' = $jsonObj.buzz.buzz
            'Sector Average News Percent' = "$($jsonObj.sectorAverageNewsScore *100)%"   
            'Sector Average Bullish Percent' = "$($jsonObj.sectorAverageBullishPercent *100)%"
            'Bears' = "$($jsonObj.sentiment.bearishPercent *100)%" 
            'Bulls' = "$($jsonObj.sentiment.bullishPercent *100)%" 
            }
        return $returnObject
    }
}

function Get-SymbolPriceTargets {
    param (
        [string] $symbol
    )
    $reponse = Invoke-WebRequest -Uri "https://finnhub.io/api/v1/stock/price-target?symbol=$($symbol)&token=$($configs.finnhub_token)"
 
    $jsonObj = ConvertFrom-Json  $reponse.Content

    if(0 -eq $jsonObj.targetHigh)
    {
        Write-Host
        Write-Host "Theres no data for $($symbol)" -ForegroundColor DarkRed
        return 
    }else {
        $returnObject =  [PSCustomObject]@{
            Symbol = $jsonObj.symbol
            'Target high' = $jsonObj.targetHigh
            'Target low' = $jsonObj.targetLow
            'Target Mean' = $jsonObj.targetMean
            'Target Median' = $jsonObj.targetMedian
            'Last Updated' = $jsonObj.lastUpdated
            }
        return $returnObject
    }
}

function Get-SymbolRecomendationTrend {
    param (
        [string] $symbol
    )
    $reponse = Invoke-WebRequest -Uri "https://finnhub.io/api/v1/stock/recommendation?symbol=$($symbol)&token=$($configs.finnhub_token)"
 
    $jsonObj = ConvertFrom-Json  $reponse.Content 

    if($null -eq $jsonObj)
    {
        Write-Host
        Write-Host "Theres no data for $($symbol)" -ForegroundColor DarkRed
        return 
    }else {
        $returnObject =  [PSCustomObject]@{
            Symbol = $jsonObj.symbol | Select-Object  -first 1
            'Buy' = $jsonObj.buy | Select-Object  -first 1
            'Strong Buy' = $jsonObj.strongBuy | Select-Object  -first 1
            'Hold' = $jsonObj.hold | Select-Object  -first 1
            'Sell' = $jsonObj.sell | Select-Object  -first 1
            'Strong Sell' = $jsonObj.strongSell | Select-Object  -first 1
            'Last Updated' = $jsonObj.period | Select-Object  -first 1
            }
        return $returnObject
    }
}

function Get-SymbolMetrics {
    param (
        [string] $symbol
    )
    $reponse = Invoke-WebRequest -Uri "https://finnhub.io/api/v1/stock/metric?symbol=$($symbol)&token=$($configs.finnhub_token)"
 
    $jsonObj = ConvertFrom-Json  $reponse.Content 

    if($null -eq $jsonObj)
    {
        Write-Host
        Write-Host "Theres no data for $($symbol)" -ForegroundColor DarkRed
        return 
    }else {
        $returnObject =  [PSCustomObject]@{
            'Beta' = $jsonObj.metric.beta
            '52 Week high' = $jsonObj.metric.'52WeekHigh'
            '52 Wekk low' = $jsonObj.metric.'52WeekLow'
            'Dividend Yield TTM' = $jsonObj.metric.currentDividendYieldTTM
            'FCF TTM' = $jsonObj.metric.freeCashFlowTTM
            'Book value per share annual' = $jsonObj.metric.bookValuePerShareAnnual 
            'Book value per share quarterly' = $jsonObj.metric.bookValuePerShareQuarterly
            'EBIT / Share' = $jsonObj.metric.ebitdPerShareTTM
            'ROI TTM' = $jsonObj.metric.roiTTM
            'Tangible B/V per share Annual' = $jsonObj.metric.tangibleBookValuePerShareAnnual
            'Tangible B/V per share Quarterly' = $jsonObj.metric.tangibleBookValuePerShareQuarterly
            'Total debt / total equity annual' = $jsonObj.metric.'totalDebt/totalEquityAnnual'
            'Total debt / total equity quarterly' = $jsonObj.metric.'totalDebt/totalEquityQuarterly'
            }
        return $returnObject
    }  
}

function Get-SymbolProfile{
    param (
        [string] $symbol
    )
    $reponse = Invoke-WebRequest -Uri "https://finnhub.io/api/v1/stock/profile2?symbol=$($symbol)&token=$($configs.finnhub_token)"
 
    $jsonObj = ConvertFrom-Json  $reponse.Content 

    if($null -eq $jsonObj)
    {
        Write-Host
        Write-Host "Theres no data for $($symbol)" -ForegroundColor DarkRed
        return 
    }else {
        $returnObject =  [PSCustomObject]@{
            'Country' = $jsonObj.country
            'Currency' = $jsonObj.currency
            'Exchange' = $jsonObj.exchange
            'Industry' = $jsonObj.finnhubIndustry
            'IPO date' = $jsonObj.ipo
            'Market Cap' = $jsonObj.marketCapitalization
            'Name' = $jsonObj.name
            'Shares Outstanding' = $jsonObj.shareOutstanding
            'Company website' = $jsonObj.weburl        
            }
        return $returnObject
    } 
}
