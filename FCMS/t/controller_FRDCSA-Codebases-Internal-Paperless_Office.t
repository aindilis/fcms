use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Internal::Paperless_Office;

ok( request('/frdcsa/codebases/internal/paperless_office')->is_success, 'Request should succeed' );
done_testing();
