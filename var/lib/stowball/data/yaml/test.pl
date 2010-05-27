#!/usr/bin/env perl
use warnings;
use strict;
use lib "/usr/lib/perl5/shiloh";
use Stowball::YAML::Yaml;

my $file = shift;
    
&yaml_to_sql( $file );
