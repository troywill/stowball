#!/bin/bash
DATABASE='/var/lib/stowball/gng-repository.db'
sqlite3 ${DATABASE} 'SELECT id, homepage_url FROM webpages order by id'


