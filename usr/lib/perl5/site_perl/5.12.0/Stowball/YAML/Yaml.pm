use strict;
use YAML::XS;

sub yaml_to_sql {

    my $YAML_FILE = shift;
    my $href = YAML::XS::LoadFile($YAML_FILE);

    my $id = $href->{id};
    my $name = $href->{name};
    my $version = $href->{version};
    print "$id: $name v$version\n";
    
# Let's print out the dependencies                                                                    
    
    my $dependencies_href = $href->{dependencies};
    
    for my $key (keys %{$dependencies_href}) {
	print "$key => ${$dependencies_href}{$key}\n";
    }
}

1;
