#!/usr/bin/env perl
use warnings;
use strict;
use YAML::XS;
use Cwd;
use File::Basename;
use Archive::Tar;
use LWP::Simple;
use File::Fetch;
use File::Spec;
use Archive::Extract;

my $file = shift;

my $source_url = &strip_source_url($file);
# system("wget --no-clobber $source_url");

my $ff = File::Fetch->new(uri=> $source_url);
my $where = $ff->fetch() or die $ff->error;

my ($base, $dir, $ext) = fileparse($source_url);

### build an Archive::Extract object ###
my $ae = Archive::Extract->new( archive => $base );
### extract to cwd() ###
my $ok = $ae->extract;

my $outdir  = $ae->extract_path;
chdir $outdir;
print  "==> $base <== ==> $dir <== ==> $ext <==\n";
    
$base = basename($outdir);
$dir  = dirname($outdir);
($base, $dir, $ext) = fileparse($outdir);
# print "$base, $dir, $ext\n";

open( my $out, '>', 'stow_script.sh' );

print $out "#!/bin/bash\n";
print $out "./configure --prefix=/usr 2>errors && make && sudo make DESTDIR=/stow/$base install && sudo stow -v $base\n";

close $out;

#########################

sub yaml_to_sql {

    my $YAML_FILE = shift;
    my $href = YAML::XS::LoadFile($YAML_FILE);

    my $id = $href->{id};
    my $name = $href->{name};
    my $version = $href->{version};
    my $script_dir = $href->{script_dir};
    my $source_url = $href->{source_url};
    print "$id: $name v$version\n";
    print "script dir: $script_dir\n";
    print "source_url: $source_url\n";
    
# Let's print out the dependencies                                                                    
    
    my $dependencies_href = $href->{dependencies};
    
    for my $key (keys %{$dependencies_href}) {
	print "$key => ${$dependencies_href}{$key}\n";
    }
}

sub strip_source_url {
    my $YAML_FILE = shift;
    my $href = YAML::XS::LoadFile($YAML_FILE);
    my $source_url = $href->{source_url};
    return $source_url;
}

sub yaml_index {
    my $YAML_FILE = shift;
    my $href = YAML::XS::LoadFile($YAML_FILE);
    my $id = $href->{id};
    my $name = $href->{name};
    my $version = $href->{version};
    print "id: $id => $name\n";
}

1;
