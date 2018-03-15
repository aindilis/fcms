use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Internal::Diamond;

ok( request('/frdcsa/codebases/internal/diamond')->is_success, 'Request should succeed' );
done_testing();
