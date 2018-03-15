use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::Debug;

ok( request('/debug')->is_success, 'Request should succeed' );
done_testing();
