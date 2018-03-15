use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Artificial_Intelligence::ReasonBase::Eolas;

ok( request('/frdcsa/artificial_intelligence/reasonbase/eolas')->is_success, 'Request should succeed' );
done_testing();
