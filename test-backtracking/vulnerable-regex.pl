

# Takes a really long time
# but doesn't cause a backtracking
# exception in perl.

use strict;
use warnings;

my $input = "a" x 19000 . "!";

my $matched;
my $except = "NO_EXCEPT";
eval {
  local $SIG{__WARN__} = sub {
    my $recursionSubStr = "Complex regular subexpression recursion limit";
    my $message = shift;
    
    # if we got a recusion limit warning
    if (index($message, $recursionSubStr) != -1) {
      $except = "RECURSION_LIMIT";
    }
    else {
      print("warning: $message");
    }
  };

  $matched = $input =~ m/(a+)+$/;

  my $did_match = $matched ? 1 : 0;
};

if ($@) {
  $except = "INVALID_INPUT";
}

print($except);

#-------------helpers


sub log {
  my ($msg) = @_;
  my $now = localtime;
  print STDERR "$now: $msg\n";
}

