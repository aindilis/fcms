use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Planning_Systems::Task_Manager;

ok( request('/frdcsa/planning_systems/task_manager')->is_success, 'Request should succeed' );
done_testing();
