use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Internal::Gourmet;

ok( request('/frdcsa/codebases/internal/gourmet')->is_success, 'Request should succeed' );
done_testing();
