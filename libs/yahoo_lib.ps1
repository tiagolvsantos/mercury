function Get-YahooOptionsCalls {
    param (
        [string]$symbol
    )
    $response = Invoke-RestMethod -Uri "https://query2.finance.yahoo.com/v7/finance/options/$($symbol)"

    if ($response.optionChain.result[0].expirationDates.Count -ge 1)
    {
        $result = foreach($options in $response.optionChain.result[0].options[0][0].calls)
        {
            [PSCustomObject]@{
                    Contract = $options.contractSymbol
                    Strike = $options.strike
                    Last_Price = $options.lastPrice
                    Change = "$([math]::Round($options.change,2))%"  
                    Percent_Change = "$([math]::Round($options.percentChange,2))%"
                    Volume = $options.volume
                    OI = $options.openInterest
                    Bid = $options.bid
                    Ask = $options.ask
                    IV = "$([math]::Round($options.impliedVolatility,2))%"
                    ITM = $options.inTheMoney
            }
        }
        return $result 
    }
}
function Get-YahooOptionsPuts {
    param (
        [string]$symbol
    )
    $response = Invoke-RestMethod -Uri "https://query2.finance.yahoo.com/v7/finance/options/$($symbol)"

    if ($response.optionChain.result[0].expirationDates.Count -ge 1)
    {
        $result = foreach($options in $response.optionChain.result[0].options[0][0].puts)
        {
            [PSCustomObject]@{
                    Contract = $options.contractSymbol
                    Strike = $options.strike
                    Last_Price = $options.lastPrice
                    Change = "$([math]::Round($options.change,2))%"  
                    Percent_Change = "$([math]::Round($options.percentChange,2))%"
                    Volume = $options.volume
                    OI = $options.openInterest
                    Bid = $options.bid
                    Ask = $options.ask
                    IV = "$([math]::Round($options.impliedVolatility,2))%"
                    ITM = $options.inTheMoney
            }
        }
        return $result 
    }
}

