use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::Security::Future;

ok( request('/security/future')->is_success, 'Request should succeed' );
done_testing();
