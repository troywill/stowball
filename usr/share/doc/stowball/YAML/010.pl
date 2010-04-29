#!/usr/bin/env perl
use warnings;
use strict;
use YAML qw(DumpFile);

&write_yaml_file;
&read_yaml_file;

exit;

sub write_yaml_file {
    my $meta = { name => "Foo::Bar", version => 1.23 };
    DumpFile( "META.yml", $meta );
}

sub read_yaml_file {
    use YAML qw(LoadFile);
    my $meta = LoadFile("META.yml");
    print $meta->{version};
}
