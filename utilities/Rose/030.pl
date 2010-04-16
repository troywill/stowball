use strict;
use warnings;
use Webpage;

my $w = Webpage->new(id => 1);
$w->load;

print $w->homepage_url;
