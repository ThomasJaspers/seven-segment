#!/usr/bin/perl

use strict;
use English;

#
# Global Variables
#
my $result = "";
my %segmentDef = (
    ABCDEFG => 8,
);

#
# Main loop reading seven segment file
#
my $segmentNum = 1;
while (<STDIN>) {
  print $ARG;
  $result .= analyseSegment($ARG, $segmentNum);
  $segmentNum++;
}

print $result . "\n";

#
# Analyse one line of a segment file
#
sub analyseSegment {

  my $sContent = $ARG[0];
  my $sNum = $ARG[1];

  return "A";
}

__END__

Mapping of segments to ids:

  A
B   C
  D
E   F
  G
