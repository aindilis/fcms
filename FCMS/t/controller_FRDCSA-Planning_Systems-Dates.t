use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Planning_Systems::Dates;

ok( request('/frdcsa/planning_systems/dates')->is_success, 'Request should succeed' );
done_testing();
