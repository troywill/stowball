use strict;
use YAML::XS;

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
    print "\nSOURCE: $source_url\n";
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
