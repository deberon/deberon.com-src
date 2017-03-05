+++
date = "2016-11-01T22:51:19-04:00"
title = "OpenSecurities: Company Info"
tags = ["python", "opensecurities", "financial", "sec"]

+++

My [OpenSecurities](https://github.com/opensecurities) project has been a rocky ride. Originally beginning life as a way for me to learn how to code in Node.js and learn MongoDB, it is now a project to track a set of tools to fetch and manipulate financial data. The scope is limited to publicly traded, US companies.

## stocks.py

This script is the first in the OpenSecurities toolset. It fetches data directly from the SEC and ouputs in a standard format. I decided this would be the best place to start since the information is readily available and manipulating is fairly straightforward.

It uses feedparser to download the RSS Atom feed from the Securities and Exchange Commission. It then outputs the data in json for further data processing.

## Commits
[Added company lookup script.](https://github.com/OpenSecurities/opensecurities/commit/f377024fbdbf4d8d5141981640060a0d4cbedcc1)
