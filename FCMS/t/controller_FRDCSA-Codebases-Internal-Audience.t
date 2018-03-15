use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Internal::Audience;

ok( request('/frdcsa/codebases/internal/audience')->is_success, 'Request should succeed' );
done_testing();
