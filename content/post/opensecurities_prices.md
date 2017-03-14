+++
date = "2017-03-13T23:53:18-05:00"
title = "OpenSecurities: Prices"
tags = ["python", "opensecurities", "financial"]

+++

The update you all have been waiting for is finally here! Or at least this is the one I've been waiting for. I finally finished an update for fetching prices. I added a new script [prices.py](https://github.com/OpenSecurities/opensecurities/blob/master/prices.py) that will download data from the [Quandl](https://www.quandl.com/) WIKI API. This API is offered for free (signup required) and is required for the script to work. Otherwise you can expect Unauthorized error messages. As with the other scrpits, a mandatory `-s <stock symbol>` parameter is required to function.

## Quandl

Prices are pulled from the QUANDL WIKI API. This API requires an API key to be used, which you are able to obtain free of charge. The key needs to be present in a $HOME/.opensecurities config file under an INI header of "quandl". Example below:

```
[quandl]
api_key=<obtain from quandl>
```

## -i, \-\-historic

The historic option will download all End Of Day (EOD) price data in the history of the provided stock. This data is exported from the Quandl API in zip and CSV format. This is then transformed by the script into JSON for further processing or viewing.

```
(.env) deberon@laptop:opensecurities[11:00 PM]$ ./prices.py -s TSLA -i | jq .[].date | (head -5; tail -5)
"2010-06-29"
"2010-06-30"
"2010-07-01"
"2010-07-02"
"2010-07-06"
"2017-03-07"
"2017-03-08"
"2017-03-09"
"2017-03-10"
"2017-03-13"
```

## -t, \-\-today

The `-t` option will download prices for that note. Please note that the prices are not available until later in the evening. The exact time they will be available is not yet known by me. And I would wager a guess that the time of availability changes from day to day.

```
(.env) deberon@laptop:opensecurities[11:01 PM]$ ./prices.py -s TSLA -t | jq .
{
  "low": 242.781,
  "open": 244.82,
  "volume": 3003644,
  "close": 246.17,
  "ex_dividend": 0,
  "high": 246.85,
  "symbol": "TSLA",
  "adj_high": 246.85,
  "adj_volume": 3003644,
  "adj_open": 244.82,
  "date": "2017-03-13",
  "split_ratio": 1,
  "adj_close": 246.17,
  "adj_low": 242.781
}
```
