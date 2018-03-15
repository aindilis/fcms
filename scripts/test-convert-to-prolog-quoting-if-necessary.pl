#!/usr/bin/perl -w

use KBS2::ImportExport;
use KBS2::Util;
use PerlLib::SwissArmyKnife;

use Error qw(:try);
use Language::Prolog::Types qw(:ctors);

my $importexport = KBS2::ImportExport->new();

my @items =
  (
   '%%T(\'WET)(&%&*%^&(@_$*!%&#@&',
   'This is a test',
   'this(is(a(test)))',
   '',
  );

foreach my $item (@items) {
  my $res0 = ConvertToPrologQuotingIfNecessary(Item => $item);
  # print DumperSingleQuote($item)."\n";
  print Dumper
    ({
      Item => $item,
      Res => $res0,
      # DSQ => DumperSingleQuote($item),
     });
  # FIXME: Throw error
}

sub ConvertToPrologQuotingIfNecessary {
  my (%args) = @_;
  try {
    my $res0 = $importexport->Convert
      (
       Input => $args{Item},
       InputType => 'Prolog',
       OutputType => 'Interlingua',
      );
    if ($res0->{Success}) {
      my $output = $res0->{Output};;
      my $dumper = Dumper($output);
      if ($dumper eq
	  Dumper([
		  'end_of_file'
		 ])) {
	throw Error();
      } elsif ($dumper eq
	       Dumper([
		       undef
		      ])) {
	throw Error();
      } else {
	return $output;
      }
    } else {
      throw Error();
    }
  } catch Error with {
    return DumperSingleQuote($args{Item});
  }
}
