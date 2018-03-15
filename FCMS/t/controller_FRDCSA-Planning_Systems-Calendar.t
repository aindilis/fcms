use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Planning_Systems::Calendar;

ok( request('/frdcsa/planning_systems/calendar')->is_success, 'Request should succeed' );
done_testing();
