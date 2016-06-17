#!/usr/bin/perl

use strict;
use English;
use Switch;


#
# Global Variables
#
my %segmentDef = (
    ABDEFG => 0, DG => 1, ACDEF => 2, ACDFG => 3, BCDG => 4,
    ABCFG => 5, ABCEFG => 6, ADG => 7, ABCDEFG => 8, ABCDFG => 9,
);

#
# Main loop reading seven segment file
#
my $segmentNum = 1;
my @numbers;
my $colOffset = 0;


while (<STDIN>) {

  s/\t+/' '/;
  my $line = $ARG;
  $line =~ s/\R//g;
  if ($line !~ /^\s*$/) {

    for (my $columns = 0; $columns < 9; $columns++ ) {
      my $oneNum = substr $line, $colOffset, 3;
      # print $oneNum . "\n";
      $numbers[$columns] .= analyseSegment($oneNum, $segmentNum);

      $colOffset += 3;
    }

    $segmentNum++;
    if ($segmentNum > 3) {
      $segmentNum = 1;
      for (my $columns = 0; $columns < 9; $columns++ ) {
        print $segmentDef{$numbers[$columns]};
      }
      print "\n";
      @numbers = ();
    }

    $colOffset = 0;
  }


  # $result .= analyseSegment($ARG, $segmentNum);
  # $segmentNum++;
}

# print $result . "\n";

#
# Analyse one line of a segment file
#
sub analyseSegment {

  my $sContent = $ARG[0];
  my $sNum = $ARG[1];
  my $result = "";

  # print $sNum . " -> " . $sContent;

  switch($sNum) {
   case 1 {
     if ($sContent =~ /^\s_\s*$/) {
       $result = "A";
     }
   }
   case 2 {
     if ($sContent =~ /^\|/) {
       $result .= "B";
     }
     if ($sContent =~ /^._/) {
       $result .= "C";
     }
     if ($sContent =~ /^..\|$/) {
       $result .= "D";
     }
   }
   case 3 {
     if ($sContent =~ /^\|/) {
       $result .= "E";
     }
     if ($sContent =~ /^._/) {
       $result .= "F";
     }
     if ($sContent =~ /^..\|$/) {
       $result .= "G";
     }
   }
   else {
     die "Unknown segment number";
   }
 }

 # print " -> " . $result . "\n";

 return $result;
}

__END__

Mapping of segments to ids:

  A
B C D
E F G
