package ShinyCMS::Controller::FRDCSA::Codebases::Minor::SPSE;

use Moose;
use namespace::autoclean;

use PerlLib::MySQL;
use PerlLib::SwissArmyKnife;


BEGIN { extends 'ShinyCMS::Controller'; }


=head1 NAME

ShinyCMS::Controller::Planning

=head1 DESCRIPTION

Controller for ShinyCMS news section.

=head1 METHODS

=cut


sub auto : Private {
  my ( $self, $c ) = @_;
  unless ( $c->user_exists ) {
    $c->stash->{ error_msg } = 'You must be logged in to use any functions.';
    $c->go( '/welcome' );
  }
  $c->stash
    (
     subsystem_name  => 'SPSE2',
     codebase_type  => 'minor',
     codebase_name  => 'spse',
    );
}


=head2 base

Set the base path.

=cut

sub index : PathPart( '' ) : Args( 0 ) {
  my ( $self, $c ) = @_;
  # this starts up the wopr system
  $c->stash
    (
     controller => 'FRDCSA::Codebases::Minor::SPSE',
     spse2_domains => $self->ListAllSPSE2Domains($c),
    );
}

=head2 view_item

View details of a news item.

=cut

sub ListAllSPSE2Domains {
  my ($self,$c,%args) = @_;
  my $mysql = PerlLib::MySQL->new
    (DBName => "freekbs2");

  # FIXME: refactor this and the one in SPSE2 to a single instance

  my $res1 = $mysql->Do
    (
     Statement => "select distinct c.Context from arguments a, arguments b, metadata m, contexts c where a.Value='frdcsa-context-type' and a.ParentFormulaID = b.ParentFormulaID and b.Value = 'SPSE' and m.FormulaID = a.ParentFormulaID and c.ID = m.ContextID order by c.Context",
     Array => 1,
    );

  my @res;
  foreach my $entry (@$res1) {
    push @res, $entry->[0];
  }
  return \@res;
}




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

