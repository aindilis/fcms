use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::ByteLibrary::Category::Data;

ok( request('/bytelibrary/category/data')->is_success, 'Request should succeed' );
done_testing();
