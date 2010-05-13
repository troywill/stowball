#!/usr/bin/env perl
use warnings;
use strict;
use Stowball::YAML::Yaml;

my $file = shift;
    
&yaml_index( $file );

