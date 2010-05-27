#!/usr/bin/env perl
use warnings;
use strict;
use lib "/usr/lib/perl5/shiloh";
use Stowball::YAML::Yaml;

my @yaml_files = <*.yml>;

foreach my $yaml_file ( @yaml_files ) {
    unless ( $yaml_file eq 'template.yml' ) {
	print "------------ $yaml_file --------------\n";
	&yaml_index( $yaml_file );
    }
}
