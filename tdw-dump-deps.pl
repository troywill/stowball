#!/usr/bin/env perl
use warnings;
use strict;

use YAML qw(DumpFile);

&write_yaml_file;
&read_yaml_file("META.yml");

exit;

sub write_yaml_file {
    my $meta = { name => "Foo::Bar", version => 1.23 };
    DumpFile( "TEMP.yml", $meta );
}

sub read_yaml_file {
    my $yaml_file = shift;
    use YAML qw(LoadFile);
    my $meta = LoadFile($yaml_file);
    print "----------\n";
    print $meta->{name}, ": ", $meta->{abstract}, "\n";
    &print_build_requires( $meta->{build_requires} );
    &print_configure_requires( $meta->{configure_requires} );
    &print_requires( $meta->{requires} );
}

sub print_build_requires {
    my $href = shift;
    for my $key (keys %{$href}) {
	print "$key => ${$href}{$key}\n" unless ${$href}{$key} == 0;
    }
}

sub print_configure_requires {
    my $href = shift;
    for my $key (keys %{$href}) {
	print "$key => ${$href}{$key}\n" unless ${$href}{$key} == 0;
    }
}

sub print_requires {
    my $href = shift;
    for my $key (keys %{$href}) {
	print "$key => ${$href}{$key}\n" unless ${$href}{$key} == 0;
    }
}

