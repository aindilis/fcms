use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::Security::Food;

ok( request('/security/food')->is_success, 'Request should succeed' );
done_testing();
