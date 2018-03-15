use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Minor::Dialog_Interface;

ok( request('/frdcsa/codebases/minor/dialog_interface')->is_success, 'Request should succeed' );
done_testing();
