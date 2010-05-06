use YAML::XS;
my $href = YAML::XS::LoadFile('sqlite.yml');
$href = YAML::XS::LoadFile('gtk+.yml');

my $id = $href->{id};
my $name = $href->{name};
my $version = $href->{version};
print "$id: $name v$version\n";
