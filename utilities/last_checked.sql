-- USEAGE: sqlite3 /var/lib/stowball/2010_spring.db < last_checked.sql

SELECT packages.date_checked, packages.short_name, packages.latest_version, webpages.homepage_url, webpages.wikipedia
FROM packages
     INNER JOIN webpages
     	   ON webpages.id = packages.id
ORDER BY packages.date_checked DESC;
