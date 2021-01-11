function Get-CboeIndicesOptions {
    $response = Invoke-RestMethod -Uri "http://markets.cboe.com/us/options/market_statistics/most_active/data/?mkt=cone&limit=25"

    foreach($type in $response.categories[1])
    {
        $calls_table = foreach ($option in $type.calls)
        {
            [PSCustomObject]@{
                Symbol = $option.symbol
                Strike = $option.strike
                Volume = $option.volume
                Expiry = $option.expires         
                }
        }
    }
    Write-Host "----------------- CBOE Most active indices Calls $(Get-Date) -----------------" -ForegroundColor DarkGreen
    $calls_table| Format-Table -AutoSize 


    foreach($type in $response.categories[1])
    {
        $puts_table = foreach ($option in $type.puts)
        {
            [PSCustomObject]@{
                Symbol = $option.symbol
                Strike = $option.strike
                Volume = $option.volume
                Expiry = $option.expires         
                }
        }
    }
    Write-Host "----------------- CBOE Most active indices Puts $(Get-Date)  -----------------" -ForegroundColor DarkRed
    $puts_table| Format-Table -AutoSize 
}

function Get-CboeEquityOptions {
    $response = Invoke-RestMethod -Uri "http://markets.cboe.com/us/options/market_statistics/most_active/data/?mkt=cone&limit=25"

    foreach($type in $response.categories[2])
    {
        $calls_table = foreach ($option in $type.calls)
        {
            [PSCustomObject]@{
                Symbol = $option.symbol
                Strike = $option.strike
                Volume = $option.volume
                Expiry = $option.expires         
                }
        }
    }
    Write-Host "----------------- CBOE Most active equity Calls $(Get-Date) -----------------" -ForegroundColor DarkGreen
    $calls_table| Format-Table -AutoSize 
    
    
    foreach($type in $response.categories[2])
    {
        $puts_table = foreach ($option in $type.puts)
        {
            [PSCustomObject]@{
                Symbol = $option.symbol
                Strike = $option.strike
                Volume = $option.volume
                Expiry = $option.expires         
                }
        }
    }
    Write-Host "----------------- CBOE Most active equity Puts $(Get-Date)  -----------------" -ForegroundColor DarkRed
    $puts_table| Format-Table -AutoSize 
}