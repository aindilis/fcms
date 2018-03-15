use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::System::Print;

ok( request('/system/print')->is_success, 'Request should succeed' );
done_testing();
