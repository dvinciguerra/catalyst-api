package CatalystBase;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;

BEGIN {
    for (qw/ CATALYST_ENV/) { defined( $ENV{$_} ) or die "missing env '$_'." }
}

use Catalyst qw/
  -Debug
  ConfigLoader
  Static::Simple
  Authentication
  Authorization::Roles
  /;

extends 'Catalyst';

our $VERSION = '0.01';

__PACKAGE__->config(
    name     => 'CatalystBase',
    encoding => "UTF-8",

    disable_component_resolution_regex_fallback => 1,
    enable_catalyst_header                      => 0,
);

__PACKAGE__->setup();
1;
