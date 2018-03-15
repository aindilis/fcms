use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Planning_Systems::Conditional_Plans;

ok( request('/frdcsa/planning_systems/conditional_plans')->is_success, 'Request should succeed' );
done_testing();
