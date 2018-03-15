use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::Security::Computer;

ok( request('/security/computer')->is_success, 'Request should succeed' );
done_testing();
