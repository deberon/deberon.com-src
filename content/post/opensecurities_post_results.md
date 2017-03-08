+++
date = "2017-03-07T21:45:38-05:00"
title = "OpenSecurities: Post Results"
tags = ["python", "opensecurities", "financial"]

+++

[OpenSecurities](https://github.com/opensecurities) has an exciting new update! While the default JSON output of the stocks.py script is meant to be well organized, it does not translate well directly into a REST resource. In my case I am using the excellent [PostgREST](https://postgrest.com/en/v0.4/). Since I am just starting on this project, it seemed easier to cater my output to what PostgREST expected as input. I added an argument (`-c`) to collapse the output into a single line heirarchy. I also added an argument (`-p`) for posting directly to an endpoint so you don't have to deal with pipes and files.

Additionally, I added a [small SQL script](https://github.com/OpenSecurities/opensecurities/blob/master/sql/tables/stocks.sql) for creating a stocks table with a schema that matches the collapsed format.

## -c, \-\-collapse

The `-c` option will take the normally structured and organized JSON output and put all attributes on a single level. This was done mostly because I have not taken the time to fully understand PostgREST, which I am sure would have a way to support nested JSON objects.


```
(.env) deberon@laptop:opensecurities[09:51 PM]$ ./stocks.py -s TSLA | jq .
{
  "cik": "0001318605",
  "address": {
    "street2": null,
    "street1": "3500 DEER CREEK RD",
    "state": "CA",
    "zip": "94070",
    "city": "PALO ALTO"
  },
  "phone": "650-681-5000",
  "symbol": "TSLA",
  "name": "Tesla, Inc."
}
(.env) deberon@laptop:opensecurities[09:51 PM]$ ./stocks.py -s TSLA -c | jq .
{
  "symbol": "TSLA",
  "street1": "3500 DEER CREEK RD",
  "name": "Tesla, Inc.",
  "zip": "94070",
  "cik": "0001318605",
  "street2": null,
  "city": "PALO ALTO",
  "state": "CA"
}
```

## -p, \-\-post

The `-p` argument takes a full URI endpoint as a parameter. This will instruct the script to send the results of the query to a REST endpoint using the HTTP POST method. Currently the only output is a listing of the HTTP response headers. I have not yet decided on a valid return for this command.

```
(.env) deberon@laptop:opensecurities[09:58 PM]$ ./stocks.py -s TSLA -c -p "http://localhost:3000/stocks"
Transfer-Encoding: chunked
Date: Wed, 08 Mar 2017 02:59:02 GMT
Server: postgrest/0.4.0.0
Location: /stocks?symbol=eq.TSLA
Content-Range: */*

(.env) deberon@laptop:opensecurities[09:59 PM]$ curl -s "localhost:3000/stocks?symbol=eq.TSLA" | jq .
[
  {
    "symbol": "TSLA",
    "name": "Tesla, Inc.",
    "cik": 1318605,
    "city": "PALO ALTO",
    "state": "CA",
    "zip": "94070",
    "street1": "3500 DEER CREEK RD",
    "street2": null
  }
]
```

## Commits
* [Added option for collapsing the output into a single level. Handy for pipes and REST.](https://github.com/OpenSecurities/opensecurities/commit/4f6441e8a351106c6812d44f479bd8bf1c743554)
* [Added option for posting results directly to an endpoint.](https://github.com/OpenSecurities/opensecurities/commit/d730e731a39b3744ce8188c59932524313e434f0)
* [Added SQl for stocks table.](https://github.com/OpenSecurities/opensecurities/commit/7e9556545a11e86aa4d35c37618ddf8b24a8ddf0)
