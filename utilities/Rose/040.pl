use strict;
use warnings;
use Webpage;
use Package;

my $w = Webpage->new(id => 1);
$w->load;
print $w->homepage_url, "\n";

my $p = Package->new(id => 1);
$p->load;
print $p->short_name, "\n";
