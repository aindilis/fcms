package ShinyCMS::Controller::FRDCSA::Codebases::Minor::Free_WOPR;

use Moose;
use namespace::autoclean;

use PerlLib::SwissArmyKnife;
use System::Cyc::UniLang::Client;

use KBS2::Util;

use WWW::Mechanize;

BEGIN { extends 'ShinyCMS::Controller'; }


=head1 NAME

ShinyCMS::Controller::FRDCSA

=head1 DESCRIPTION

Controller for ShinyCMS news section.

=head1 METHODS

=cut


=head2 base

Set the base path.

=cut


sub auto : Private {
  my ( $self, $c ) = @_;
  unless ( $c->user_exists ) {
    $c->stash->{ error_msg } = 'You must be logged in to use any functions.';
    $c->go( '/welcome' );
  }
}

sub index : PathPart( '' ) : Args( 0 ) {
  my ( $self, $c ) = @_;
  my $results = $c->model( 'FRDCSA' )->Query
    (
     $c,
     Eval => [
	      [
	       '_prolog_list',
	       Var('?Result'),
	       ['generatePageFor','freeWOPR',Var('?Result')]]
	     ]
    );
  print Dumper({FreeWOPRResults => $results});
  $c->stash
    (
     codebase_type  => 'minor',
     codebase_name   => 'free-wopr',
     subsystem_name  => 'Free WOPR',
     subsystem_association => 'Contingencies',
     results => $results,
    );
}

sub new_solution : Local : Args( 0 ) {
  my ( $self, $c ) = @_;

  my $user = (exists $c->session->{__user} ? $c->session->{__user}{username} : 'User');
  my $contingency = $self->prepare_possible_assertion($c,$c->request->params->{ contingency });

  my @results;
  if (exists $c->request->params->{ solution }) {
    my $preconditions = $self->prepare_possible_assertion($c,$c->request->params->{ preconditions });
    push @results,
      {
       Preconditions => $c->model( 'FRDCSA' )->Query
       (
	$c,
	Eval => [
		 ['_prolog_list',
		  Var('?Result'),
		  ['fassert','Agent1','Yaswi1',
		   ['preconditionsForContingency', $user, $contingency, $preconditions],
		   Var('?Result'),
		  ]
		 ]
		],
       ),
      };
  }
  if (exists $c->request->params->{ effects }) {
    my $effects = $self->prepare_possible_assertion($c,$c->request->params->{ effects });
    push @results,
      {
       Effects => $c->model( 'FRDCSA' )->Query
       (
	$c,
	Eval => [
		 ['_prolog_list',
		  Var('?Result'),
		  ['fassert','Agent1','Yaswi1',
		   ['effectsForContingency', $user, $contingency, $effects],
		   Var('?Result'),
		  ]
		 ]
		],
       ),
      };
  }
  if (exists $c->request->params->{ solution }) {
    my $solution = $self->prepare_possible_assertion($c,$c->request->params->{ solution });
    push @results,
      {
       Solution => $c->model( 'FRDCSA' )->Query
       (
	$c,
	Eval => [
		 ['_prolog_list',
		  Var('?Result'),
		  ['fassert','Agent1','Yaswi1',
		   ['suggestedResponse', $user, $contingency, $solution],
		   Var('?Result'),
		  ]
		 ]
		],
       ),
      };
  }

  # display a modal with the result
  $c->stash
    (
     results => \@results,
     template => 'frdcsa/codebases/minor/free_wopr/new_solution.tt',
    );
}

sub prepare_possible_assertion {
  my ( $self, $c, $item ) = @_;
  my $res1 = $c->model('FRDCSA')->ConvertToPrologQuotingIfNecessary(Item => $item);
  my $ref1 = ref($res1);
  if ($ref1 eq 'ARRAY') {
    return $res1->[0];
  } else {
    return $res1;
  }
}

sub contingency : Local : CaptureArgs( 1 ) {
  my ( $self, $c, $contingencyname ) = @_;
  eval {$c->assert_user_roles( qw/Strategist/ )};
  $c->stash
    (
     contingency_name => $contingencyname,
     coas =>
     {
      'paintedWithStigmaSuchAsShiftless(meredithMcGhan)' =>
      {
       coas => [
		{
		 counterStigmaBothOnSelfAndOthers => {
								    Assumptions => [
										   ],
								   },
		},
	       ],
      },
      'aiNotDoneInTime' =>
      {
       coas => [
		{
		 havePreexistingJobsLinedUpAsMuchAsPossible => {
								Assumptions => [],
							       },
		},
		{
		 haveSourceOfFinancialSupportLinedUp => {
							 Assumptions => [],
							},
		},
	       ],
      },
     });
}

sub new_contingency :Local :Args(0) {
  my ( $self, $c ) = @_;
  if (0) {
    $c->stash
      (
       params_dump => Dumper($c->request->params),
      );
  }
  my $res1 = $c->model( 'FRDCSA' )->QueryAgent
    (
     Receiver => 'Guardian',
     Data => {
	      Command => 'new-contingency',
	      Contingency => $c->request->params->{contingency},
	     },
    );
  $c->stash
    (
     query_result => $res1,
     template => 'frdcsa/codebases/minor/free_wopr/index.tt',
    );
  $self->index($c);
}

# sub contingencies : Chained( 'free_wopr' ) : PathPart( 'contingencies' ) : CaptureArgs( 1 ) {
#   my ( $self, $c, $contingencyname ) = @_;

#   $c->stash->{ subsystem_name } = 'Blah2';
# }


# sub add_contingency : Chained( 'free_wopr' ) : PathPart( 'add_contingency' ) : Args( 0 ) {
#   my ( $self, $c ) = @_;

#   # go ahead and add the wopr to the KBS
#   $c->stash->{ subsystem_name } = 'Aha!';
# }

=head1 AUTHOR

Andrew Dougherty <andrewdo@frdcsa.org>

=head1 COPYRIGHT

ShinyCMS is copyright (c) 2009-2015 Shiny Ideas (www.shinyideas.co.uk).

=head1 LICENSE

This program is free software: you can redistribute it and/or modify it 
under the terms of the GNU Affero General Public License as published by 
the Free Software Foundation, either version 3 of the License, or (at your 
option) any later version.

You should have received a copy of the GNU Affero General Public License 
along with this program (see docs/AGPL-3.0.txt).  If not, see 
http://www.gnu.org/licenses/

=cut

__PACKAGE__->meta->make_immutable;

1;

