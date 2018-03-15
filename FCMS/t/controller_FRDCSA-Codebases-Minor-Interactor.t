use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Minor::Interactor;

ok( request('/frdcsa/codebases/minor/interactor')->is_success, 'Request should succeed' );
done_testing();
