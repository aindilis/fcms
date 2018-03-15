#==============================================================================
# 
# Template::Plugin::SWIPLI
#
# DESCRIPTION
#
# A Template Plugin to provide a Template Interface to Data::SWIPLI
#
# AUTHOR
#   Simon Matthews <sam@tt2.org>
#
# COPYRIGHT
#   Copyright (C) 2000 Simon Matthews.  All Rights Reserved
#
#   This module is free software; you can redistribute it and/or
#   modify it under the same terms as Perl itself.
#
#==============================================================================

package Template::Plugin::SWIPLI;

use strict;
use warnings;
use base 'Template::Plugin';

use Formalog::Util::SWIPLI;

use Data::Dumper;

our $VERSION = 0.01;
our $DEBUG   = 0 unless defined $DEBUG;
our $AUTOLOAD;

#==============================================================================
#                      -----  CLASS METHODS -----
#==============================================================================

#------------------------------------------------------------------------
# new($context, \@params)
#------------------------------------------------------------------------

sub new {
    my ($class, $context, $params) = @_;
    my ($key, $val);
    $params ||= { };

    bless { 
        _CONTEXT => $context, 
    }, $class;
}

sub GetHash {
  my ($context, $params) = @_;
  SWIPLIGetHash(Interlingua => $params);
}

sub GetList {
  my ($context, $params) = @_;
  SWIPLIGetList(Interlingua => $params);
}

sub DropAnnotations {
  my ($context, $params) = @_;
  SWIPLIDropAnnotations(Interlingua => $params);
}

sub ToProlog {
  my ($context,$c,$params) = @_;
  return $c->model( 'FRDCSA' )->Convert
    (
     Input => [$params],
     InputType => 'Interlingua',
     OutputType => 'Prolog',
    );
}

1;

__END__

=head1 NAME

Template::Plugin::SWIPLI - Plugin interface to Data::SWIPLI

=head1 SYNOPSIS

    [% USE SWIPLI %]
    
    [% SWIPLI.dump(variable) %]
    [% SWIPLI.dump_html(variable) %]

=head1 DESCRIPTION

This is a very simple Template Toolkit Plugin Interface to the L<Data::SWIPLI>
module.  A C<SWIPLI> object will be instantiated via the following directive:

    [% USE SWIPLI %]

As a standard plugin, you can also specify its name in lower case:

    [% USE dumper %]

The C<Data::SWIPLI> C<Pad>, C<Indent> and C<Varname> options are supported
as constructor arguments to affect the output generated.  See L<Data::SWIPLI>
for further details.

    [% USE dumper(Indent=0, Pad="<br>") %]

These options can also be specified in lower case.

    [% USE dumper(indent=0, pad="<br>") %]

=head1 METHODS

There are two methods supported by the C<SWIPLI> object.  Each will
output into the template the contents of the variables passed to the
object method.

=head2 dump()

Generates a raw text dump of the data structure(s) passed

    [% USE SWIPLI %]
    [% SWIPLI.dump(myvar) %]
    [% SWIPLI.dump(myvar, yourvar) %]

=head2 dump_html()

Generates a dump of the data structures, as per L<dump()>, but with the 
characters E<lt>, E<gt> and E<amp> converted to their equivalent HTML
entities and newlines converted to E<lt>brE<gt>.

    [% USE SWIPLI %]
    [% SWIPLI.dump_html(myvar) %]

=head1 AUTHOR

Simon Matthews E<lt>sam@tt2.orgE<gt>

=head1 COPYRIGHT

Copyright (C) 2000 Simon Matthews.  All Rights Reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 SEE ALSO

L<Template::Plugin>, L<Data::SWIPLI>

