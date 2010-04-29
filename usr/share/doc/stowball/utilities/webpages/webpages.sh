#!/bin/bash
DATABASE='/var/lib/stowball/gng-repository.db'
# sqlite3 ${DATABASE} 'SELECT id, homepage_url, wikipedia_url FROM webpages order by id'
sqlite3 ${DATABASE} 'SELECT packages.id, packages.short_name, webpages.homepage_url FROM webpages INNER JOIN packages ON webpages.id = packages.id'



