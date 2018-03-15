use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::Security::Physical;

ok( request('/security/physical')->is_success, 'Request should succeed' );
done_testing();
