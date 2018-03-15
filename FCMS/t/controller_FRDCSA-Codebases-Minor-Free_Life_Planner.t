use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Minor::Free_Life_Planner;

ok( request('/frdcsa/codebases/minor/free_life_planner')->is_success, 'Request should succeed' );
done_testing();
