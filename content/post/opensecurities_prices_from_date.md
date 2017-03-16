+++
date = "2017-03-15T22:58:50-04:00"
title = "OpenSecurities: Prices From Date"
tags = ["python", "opensecurities", "financial"]

+++

Due to a bad memory and a lack of dilegence, I often forget to update my price table. Since I have not yet put my database on a server, my laptop is not always available for a cron entry. So I had to put in a way to download a differential set of prices based on a specific date. This will allow me to catch up my prices table if I've been away for a wile. So I introduced a `-f/--from-date` option to the [prices.py](https://github.com/OpenSecurities/opensecurities/blob/master/prices.py) script.

## -f , \-\-from-date

Downloads all prices for the given stock symbol since the provided "from date". The returned results would include any days after, but not including, the from date.

```
(.env) deberon@laptop:opensecurities[11:30 PM]$ ./prices.py -s TSLA -f "2017-03-10" | jq -r .[].date
2017-03-13
2017-03-14
2017-03-15
```
