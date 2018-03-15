package ShinyCMS::View::HTML;

use Capability::Deidentify;

use Moose;
use namespace::clean -except => 'meta';
use Data::Dumper;

# Template::Filters
extends 'Catalyst::View::TT';

{
  $UNIVERSAL::deidentifier =
    Capability::Deidentify->new
      (
      );
}

use Template::Filters;  # Need to use, so that we can have access to $Template::Filters::FILTERS
$Template::Filters::FILTERS->{html} = \&html_scrubber_filter;

sub html_scrubber_filter {
  my $text1 = shift;

  # Choose to deidentify (FIXME: refactor this to a config or debug setting)
  my $deidentify = 0;

  my $text2;
  if ($deidentify) {
    # Return the (deidentified) filtered HTML
    $text2 = Deidentify
      (
       Text => $text1,
       UseSayer => 1,
      );
  } else {
    # Return the filtered HTML
    $text2 = $text1;
  }

  for ($text2) {
    s/&/&amp;/g;
    s/</&lt;/g;
    s/>/&gt;/g;
    s/"/&quot;/g;
  }
  return $text2;
}

sub Deidentify {
  my (%args) = @_;
  my $text = $args{Text};
  my $res1 = $UNIVERSAL::deidentifier->Deidentify
    (
     Text => $text,
     UseSayer => 1,
    );
  print Dumper({Res1 => $res1});
  if ($res1->{Success}) {
    return $res1->{Result}{Redacted};
  } else {
    return $text;
  }
}

=head1 NAME

ShinyCMS::View::HTML

=head1 DESCRIPTION

HTML view for ShinyCMS.

=head1 SEE ALSO

L<ShinyCMS>

=head1 AUTHOR

Denny de la Haye <2018@denny.me>

=head1 LICENSE

This program is free software: you can redistribute it and/or modify it 
under the terms of the GNU Affero General Public License as published by 
the Free Software Foundation, either version 3 of the License, or (at your 
option) any later version.

You should have received a copy of the GNU Affero General Public License 
along with this program (see docs/AGPL-3.0.txt).  If not, see 
http://www.gnu.org/licenses/

=cut

1;
