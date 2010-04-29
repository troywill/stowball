use strict;
use warnings;
use Webpage;
use Package;

my $p1 = Package->new(id => 1);
$p1->load;
print $p1->short_name, "\n";


my $p5 = Package->new(id => 5);
$p5->load;
print $p5->short_name, "\n";
print join ( "\n", keys %{$p5} );

for ( 1..25 ) {
    print "---------------\n";
    my $p = Package->new(id => $_);
    $p->load;
    print "$_ : ", $p->short_name, "\n";
    sleep 1;
}
