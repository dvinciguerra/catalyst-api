package CatalystBase::Model::DB;

use strict;
use base 'Catalyst::Model::DBIC::Schema';

use CatalystBase::SchemaConnected qw(get_connect_info);

__PACKAGE__->config(
    schema_class => 'CatalystBase::Schema',
    connect_info => get_connect_info(),
);

1;
