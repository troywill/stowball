package Webpage;

use base My::DB::Object;

__PACKAGE__->meta->setup
    (
     table      => 'webpages',
     columns    => [ qw( id homepage_url wikipedia_url lfs_url date_checked ) ],
     pk_columns => 'id'
    );

sub init_db { My::DB->new }
