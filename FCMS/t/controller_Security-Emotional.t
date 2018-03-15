use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::Security::Emotional;

ok( request('/security/emotional')->is_success, 'Request should succeed' );
done_testing();
