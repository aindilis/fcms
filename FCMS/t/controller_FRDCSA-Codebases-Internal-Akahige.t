use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Internal::Akahige;

ok( request('/frdcsa/codebases/internal/akahige')->is_success, 'Request should succeed' );
done_testing();
