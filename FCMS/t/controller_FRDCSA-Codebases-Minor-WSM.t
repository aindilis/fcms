use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Minor::WSM;

ok( request('/frdcsa/codebases/minor/wsm')->is_success, 'Request should succeed' );
done_testing();
