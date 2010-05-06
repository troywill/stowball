use strict;
use Data::Dumper;
use YAML::XS;
my $href = YAML::XS::LoadFile('sqlite.yml');
$href = YAML::XS::LoadFile('gtk+.yml');

my $id = $href->{id};
my $name = $href->{name};
my $version = $href->{version};
print "$id: $name v$version\n";

print Dump($href);
print Dumper($href);

# Let's print out the dependencies
# Let's print out the dependencies                                                                    

$dependencies_href = $href->{dependencies};

for my $key (keys %{$dependencies_href}) {
    print "$key => ${$href}{$key}\n";
}

1;
