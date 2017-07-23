use strict;
use warnings;
use Test::More;


use Catalyst::Test 'CatalystAPI';
use CatalystAPI::Controller::V1::User;

ok( request('/v1/user')->is_success, 'Request should succeed' );
done_testing();
