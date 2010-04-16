package Package;
use My::DB;
use base qw(Rose::DB::Object);

__PACKAGE__->meta->setup
    (
     table      => 'packages',
     columns    => [ qw( id short_name name latest_version date_released date_checked ) ],
     pk_columns => 'id'
    );

sub init_db { My::DB->new }
