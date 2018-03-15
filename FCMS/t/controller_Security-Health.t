use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::Security::Health;

ok( request('/security/health')->is_success, 'Request should succeed' );
done_testing();
