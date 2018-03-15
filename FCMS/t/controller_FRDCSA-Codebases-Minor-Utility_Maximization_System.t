use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Minor::Utility_Maximization_System;

ok( request('/frdcsa/codebases/minor/utility_maximization_system')->is_success, 'Request should succeed' );
done_testing();
