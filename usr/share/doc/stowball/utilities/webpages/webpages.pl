#!/usr/bin/env perl
use strict;
use warnings;
use DBI;
use ConfigReader::Simple;

open( HTML, '>/var/www/code.troywill.com/webpages.html') || die "Unable to open file for writing";

my $DATABASE = '/var/lib/stowball/gng-repository.db';
my $dbh = DBI->connect("dbi:SQLite:$DATABASE", "", "", {RaiseError => 1, AutoCommit => 1});

# my $query = qq(SELECT packages.id, packages.latest_version, packages.short_name, webpages.homepage_url, webpages.wikipedia_url, webpages.lfs_url FROM webpages INNER JOIN packages ON webpages.id = packages.id where packages.date_checked > '2010-03-01' ORDER BY UPPER(packages.short_name));
my $query = qq(SELECT packages.id, packages.latest_version, packages.short_name, webpages.homepage_url, webpages.wikipedia_url, webpages.lfs_url FROM webpages INNER JOIN packages ON webpages.id = packages.id where packages.date_checked > '2010-03-01' ORDER BY packages.date_checked DESC);
my $sth = $dbh->prepare($query);
$sth->execute();

print HTML "<TABLE>\n";
print HTML "<TH>Package</TH><TH>Wikipedia</TH><TH>BLFS</TH><TH>Homepage</TH>\n";
my @values =();
while (my ($id, $latest_version, $short_name, $homepage_url, $wikipedia_url, $lfs_url ) = $sth->fetchrow_array) {
    print "$id, $short_name, $homepage_url\n";
    print HTML "<TR><TD>$short_name-$latest_version</TD><TD><a href='$wikipedia_url'>Wikipedia</TD><TD><a href='$lfs_url'>(B)LFS</TD><TD><a href='$homepage_url'>$homepage_url</a></TD></TR>\n";
}
print HTML "</TABLE>\n";

# sqlite3 ${DATABASE} 'SELECT id, homepage_url, wikipedia_url FROM webpages order by id'
# sqlite3 ${DATABASE} 'SELECT packages.id, packages.short_name, webpages.homepage_url FROM webpages INNER JOIN packages ON webpages.id = packages.id'
