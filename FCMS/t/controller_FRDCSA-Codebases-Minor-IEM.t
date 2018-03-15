use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Minor::IEM;

ok( request('/frdcsa/codebases/minor/iem')->is_success, 'Request should succeed' );
done_testing();
