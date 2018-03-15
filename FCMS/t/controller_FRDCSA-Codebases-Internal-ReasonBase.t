use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Internal::ReasonBase;

ok( request('/frdcsa/codebases/internal/reasonbase')->is_success, 'Request should succeed' );
done_testing();
