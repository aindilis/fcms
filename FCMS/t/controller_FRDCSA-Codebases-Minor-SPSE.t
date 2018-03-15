use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Minor::SPSE;

ok( request('/frdcsa/codebases/minor/spse')->is_success, 'Request should succeed' );
done_testing();
