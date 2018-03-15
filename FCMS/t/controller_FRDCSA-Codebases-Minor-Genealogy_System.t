use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Minor::Genealogy_System;

ok( request('/frdcsa/codebases/minor/genealogy_system')->is_success, 'Request should succeed' );
done_testing();
