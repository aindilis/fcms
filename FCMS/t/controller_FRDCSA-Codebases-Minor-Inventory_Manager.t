use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Minor::Inventory_Manager;

ok( request('/frdcsa/codebases/minor/inventory_manager')->is_success, 'Request should succeed' );
done_testing();
