use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::Security::AI;

ok( request('/security/ai')->is_success, 'Request should succeed' );
done_testing();
