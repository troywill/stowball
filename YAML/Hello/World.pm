package Hello::World;
use strict;
use warnings;
our $VERSION = '1.00';
use base 'Exporter';

our @EXPORT = qw(hello);

sub hello {
    my $target = shift;
    $target = 'world' unless defined $target;
    return "Hello, $target!\n";
}
