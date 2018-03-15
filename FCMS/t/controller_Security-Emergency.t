use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::Security::Emergency;

ok( request('/security/emergency')->is_success, 'Request should succeed' );
done_testing();
