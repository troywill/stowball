#!/usr/bin/env perl
my $rsync_module = 'troywill.com::stowballs';
my $download_dir = '/tmp';
my $stow_dir     = '/stow';

my @stow_packages = (
    'Text-CSV-1.17',   'ConfigReader-Simple-1.28',
    'DBD-SQLite-1.29', 'rsync-3.0.7',
    'sqlite-3.6.23.1', 'libxml2-2.7.7', 'libxslt-1.1.26'
);

# Retrieve
foreach my $stow_package (@stow_packages) {
    &fetch_stowball($stow_package );
    &unpack_and_stow ( $stow_package );
}

    sub fetch_stowball {
	my $stow_package = shift;
	my $stowball      = $stow_package . '.stow.tar.bz2';
	my $shell_command = "rsync --archive $rsync_module/$stowball $download_dir";
	print "\n==> $stowball\n";
	print `$shell_command`;
    }


    sub unpack_and_stow ( ) {
	my $stow_package = shift;
	my $stowball = $stow_package . '.stow.tar.bz2';
	chdir $stow_dir;
	my $shell_command = "sudo tar --extract --file $download_dir/$stowball";
	my $stow_command  = "sudo stow --verbose $stow_package";
	print `$shell_command`;
	print `$stow_command`;
    }




# Unpack and stow

__END__

foreach my $stow_package (@stow_packages) {
    my $stowball = $stow_package . '.stow.tar.bz2';
    chdir $stow_dir;
    my $shell_command = "sudo tar --extract --file $download_dir/$stowball";
    my $stow_command  = "sudo stow --verbose $stow_package";
    print `$shell_command`;
    print `$stow_command`;
}
