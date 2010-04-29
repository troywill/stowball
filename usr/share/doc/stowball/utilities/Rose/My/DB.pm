package My::DB;

use Rose::DB;
our @ISA = qw(Rose::DB);

# Use a private registry for this class
__PACKAGE__->use_private_registry;

# Register your lone data source using the default type and domain
__PACKAGE__->register_db(
    domain   => My::DB->default_domain,
    type     => My::DB->default_type,
    driver   => 'sqlite',
    database => '/var/lib/stowball/2010_spring.db'
    );
