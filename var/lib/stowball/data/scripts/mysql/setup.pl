#!/usr/bin/env perl
use warnings;
use strict;
use Shiloh::Servers::MySQL;

my $config = MySQL->new();
$config->setup();
