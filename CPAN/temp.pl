use strict;
use warnings;
use File::Find;

my @files;

# find(
#     {
# 	wanted => sub {
# 	    push @files, $File::Find::fullname
# 		if -f $File::Find::fullname && /\.pm$/
# 	},
#                 follow => 1,
#                 follow_skip => 2,
#     },
#     @INC
#     );

# print join "\n", @files;

find(
    {
	wanted => sub {
	    push @files, $File::Find::name
		if -f $File::Find::name && /\.pm$/
	},
                follow => 1,
                follow_skip => 2,
    },
    "/stow/perl-5.12.0"
    );

print join "\n", @files;
