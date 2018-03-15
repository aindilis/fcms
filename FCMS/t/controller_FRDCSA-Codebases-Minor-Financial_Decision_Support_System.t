use strict;
use warnings;
use Test::More;


use Catalyst::Test 'ShinyCMS';
use ShinyCMS::Controller::FRDCSA::Codebases::Minor::Financial_Decision_Support_System;

ok( request('/frdcsa/codebases/minor/financial_decision_support_system')->is_success, 'Request should succeed' );
done_testing();
