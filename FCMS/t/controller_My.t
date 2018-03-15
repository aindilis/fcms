use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::My;

ok( request('/my')->is_success, 'Request should succeed' );
done_testing();
