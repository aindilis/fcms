use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Work::Help_At_Home;

ok( request('/frdcsa/codebases/work/help_at_home')->is_success, 'Request should succeed' );
done_testing();
