use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Minor::Plan_Integrator;

ok( request('/frdcsa/codebases/minor/plan_integrator')->is_success, 'Request should succeed' );
done_testing();
