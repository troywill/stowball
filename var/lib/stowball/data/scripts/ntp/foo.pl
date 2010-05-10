#!/usr/bin/evn perl
use warnings;
use strict;
use Net::NTP;
my %response = get_ntp_response('pool.ntp.org');
foreach my $key ( keys %response ) {
#    print "$key\t$response{$key}\n";
}
my $time = time;
my $ntp_time = $response{'Transmit Timestamp'};

my $date = scalar localtime($ntp_time);

print "Perl says date is $date\n";
print `date --set='$date'`;

