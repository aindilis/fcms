package ShinyCMS::Model::FRDCSA;

use Moose;

use Eolas::Annotator;
use PerlLib::SwissArmyKnife;

extends 'Catalyst::Model';

=head1 NAME

ShinyCMS::Model::FRD

=head1 SYNOPSIS

See L<ShinyCMS>

=head1 DESCRIPTION

L<Catalyst::Model::DBIC::Schema> Model using schema L<ShinyCMS::Schema>

=cut

has 'EolasAnnotator' => (is  => 'rw', isa => 'Eolas::Annotator', lazy => 1, default => sub {Eolas::Annotator->new()}, handles => [qw(Annotate)]);

=head1 AUTHOR

Andrew Dougherty <andrewdo@frdcsa.org>

=head1 LICENSE

This program is free software: you can redistribute it and/or modify it 
under the terms of the GNU Affero General Public License as published by 
the Free Software Foundation, either version 3 of the License, or (at your 
option) any later version.

You should have received a copy of the GNU Affero General Public License 
along with this program (see docs/AGPL-3.0.txt).  If not, see 
http://www.gnu.org/licenses/

=cut

#  __PACKAGE__->meta->make_immutable;
# no Moose;
1;
