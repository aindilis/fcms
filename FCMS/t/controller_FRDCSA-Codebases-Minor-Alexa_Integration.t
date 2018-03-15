use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Minor::Alexa_Integration;

ok( request('/frdcsa/codebases/minor/alexa_integration')->is_success, 'Request should succeed' );
done_testing();
