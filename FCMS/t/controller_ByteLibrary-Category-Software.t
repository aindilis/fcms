use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::ByteLibrary::Category::Software;

ok( request('/bytelibrary/category/software')->is_success, 'Request should succeed' );
done_testing();
