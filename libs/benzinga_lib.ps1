function Get-DailyRatings {
    $date = Get-Date

    $response = Invoke-RestMethod -Uri "https://www.benzinga.com/services/webapps/calendar/ratings?token=bcb21f0e5c2ec60fc1fa834444cf04665e04175a6e860cd5d27c9f25e31808d1&pagesize=500&parameters[date]=$($date.ToString("yyyy-MM-dd"))&parameters[date_from]=&parameters[date_to]=&parameters[importance]=0&parameters[action]=&callback=calendarWebclientGetDateCB"
    $response = $response.Replace("calendarWebclientGetDateCB(","").Replace(")","")
    
    $json_object = $response | ConvertFrom-Json
    
    $ratings_table = foreach($rating in $json_object.data.ratings)
    {
       [PSCustomObject]@{
            Symbol = $rating.ticker
            Company = $rating.name
            Firm = $rating.analyst
            Action = $rating.action_company
            From = $rating.rating_prior
            To = $rating.rating_current
            PT_Prior = $rating.pt_prior
            Price = $rating.pt_current
            Benzinga = $rating.url
            Yahoo = "https://finance.yahoo.com/quote/$($rating.ticker)"
        }
    }
    return $ratings_table
}