#!/usr/bin/env perl
my $rsync_module = 'troywill.com::stowballs';
my $download_dir = '/tmp';
my $stow_dir = '/stow';

my @stow_packages = ( 'Text-CSV-1.17', 'ConfigReader-Simple-1.28', 'DBD-SQLite-1.29', 'rsync-3.0.7' );

# Retrieve
foreach my $stow_package ( @stow_packages ) {
    my $stowball = $stow_package . '.stow.tar.bz2';
    my $shell_command = "rsync --archive $rsync_module/$stowball $download_dir";
    print "\n==> $stowball\n";
    print `$shell_command`;
}

# Unpack and stow
foreach my $stow_package ( @stow_packages ) {
    my $stowball = $stow_package . '.stow.tar.bz2';
    chdir $stow_dir;
    my $shell_command = "tar --extract --file $download_dir/$stowball";
    print `$shell_command`;
}
