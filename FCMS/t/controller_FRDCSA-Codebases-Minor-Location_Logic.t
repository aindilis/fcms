use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Minor::Location_Logic;

ok( request('/frdcsa/codebases/minor/location_logic')->is_success, 'Request should succeed' );
done_testing();
