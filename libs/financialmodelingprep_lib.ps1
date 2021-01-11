$configs = Get-Content "configs\config_file.json" | ConvertFrom-Json


function Get-SymbolQuote {
    param (
        [string] $symbol
    )
    
    $reponse = Invoke-WebRequest -Uri "https://financialmodelingprep.com/api/v3/quote/$($symbol)?apikey=$($configs.financialmodelingprep_token)"
 
    $jsonObj = ConvertFrom-Json  $reponse.Content 

    if($null -eq $jsonObj)
    {
        Write-Host
        Write-Host "Theres no data for $($symbol)" -ForegroundColor DarkRed
        return 
    }else {
        $returnObject =  [PSCustomObject]@{
         'Last' = $jsonObj.price
         'Open' = $jsonObj.open
         'High' = $jsonObj.dayHigh
         'Low' = $jsonObj.dayLow
         '% Change' = "$($jsonObj.changesPercentage)%"
         'Change' = $jsonObj.change
         'Previous Close' = $jsonObj.previousClose
         '50D avg price' = $jsonObj.priceAvg50
         '200D avg price' = $jsonObj.priceAvg200
         'Volume' = $jsonObj.volume
         'Avg Volume' = $jsonObj.avgVolume
         'Market Cap.' = $jsonObj.marketCap
         'EPS' = $jsonObj.eps
         'PE' = $jsonObj.pe
         'Shares Outstanding' = $jsonObj.sharesOutstanding
         'Exchange' = $jsonObj.exchange
            }
        return $returnObject
    }  
}

function Get-SymbolNews {
    param (
        [string] $symbol
    )

    $reponse = Invoke-WebRequest -Uri "https://financialmodelingprep.com/api/v3/stock_news?tickers=$($symbol)&limit=50&apikey=$($configs.financialmodelingprep_token)"

    $jsonObj = ConvertFrom-Json  $reponse.Content 

    if ($null -eq $jsonObj) {
        Write-Host
        Write-Host "Theres no news for $($symbol)" -ForegroundColor DarkRed
        return 
    }
    else {
        $result = foreach ($new in $jsonObj) {
            [PSCustomObject]@{
                'Title' = $new.title
                'URL'   = $new.url
                'Date'  = $new.publishedDate
            }
        }
        return $result
    }  
} 
