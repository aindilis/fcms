use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Internal::Disciple;

ok( request('/frdcsa/codebases/internal/disciple')->is_success, 'Request should succeed' );
done_testing();
