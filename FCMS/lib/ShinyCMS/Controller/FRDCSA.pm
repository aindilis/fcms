package ShinyCMS::Controller::FRDCSA;

use Moose;
use namespace::autoclean;

use PerlLib::SwissArmyKnife;
use System::Cyc::UniLang::Client;


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

sub introduction : Local : Args( 0 ) {
  my ( $self, $c ) = @_;

  $c->stash->{ subsystem_name } = 'FRDCSA Introduction';
}

sub i_want_my_own_frdcsa : Local : Args(0) {
    my ( $self, $c ) = @_;
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

