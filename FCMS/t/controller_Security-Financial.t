use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::Security::Financial;

ok( request('/security/financial')->is_success, 'Request should succeed' );
done_testing();
