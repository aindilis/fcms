use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Minor::NLU_MF;

ok( request('/frdcsa/codebases/minor/nlu_mf')->is_success, 'Request should succeed' );
done_testing();
