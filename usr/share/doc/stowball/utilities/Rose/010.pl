use My::DB;

$db = My::DB->new(); # use default type and default domain
print $db->username; # "joeuser"
$dbh = $db->dbh;     # connect and get DBI database handle
