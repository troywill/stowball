#!/usr/bin/env perl
my $rsync_module = 'troywill.com::stowballs';
my $download_dir = '/tmp';

my @stowballs = ( 'Text-CSV-1.17', 'ConfigReader-Simple-1.28', 'DBD-SQLite-1.29', 'rsync-3.0.7' );

foreach my $stowball ( @stowballs ) {
    $stowball = $stowball . '.stow.tar.bz2';
    my $shell_command = "rsync --archive --progress $rsync_module/$stowball $download_dir";
    print "\n==> $stowball\n";
    print `$shell_command`;
}
