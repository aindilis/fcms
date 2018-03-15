use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::Security::Social;

ok( request('/security/social')->is_success, 'Request should succeed' );
done_testing();
