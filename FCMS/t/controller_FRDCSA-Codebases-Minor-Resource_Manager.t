use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Minor::Resource_Manager;

ok( request('/frdcsa/codebases/minor/resource_manager')->is_success, 'Request should succeed' );
done_testing();
