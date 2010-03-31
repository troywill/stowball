#!/usr/bin/env perl
use strict;
use warnings;
use DBI;
use ConfigReader::Simple;

open( HTML, '>webpages.html') || die "Unable to open file for writing";

my $DATABASE = '/var/lib/stowball/gng-repository.db';
my $dbh = DBI->connect("dbi:SQLite:$DATABASE", "", "", {RaiseError => 1, AutoCommit => 1});

my $query = qq(SELECT packages.id, packages.short_name, webpages.homepage_url FROM webpages INNER JOIN packages ON webpages.id = packages.id ORDER BY packages.short_name);
my $sth = $dbh->prepare($query);
$sth->execute();

print HTML "<TABLE>\n";
my @values =();
while (my ($id, $short_name, $homepage_url ) = $sth->fetchrow_array) {
    print "$id, $short_name, $homepage_url\n";
    print HTML "<TR><TD>$short_name</TD><TD><a href='$homepage_url'>$homepage_url</a></TD></TR>\n";
}
print HTML "</TABLE>\n";

# sqlite3 ${DATABASE} 'SELECT id, homepage_url, wikipedia_url FROM webpages order by id'
# sqlite3 ${DATABASE} 'SELECT packages.id, packages.short_name, webpages.homepage_url FROM webpages INNER JOIN packages ON webpages.id = packages.id'
