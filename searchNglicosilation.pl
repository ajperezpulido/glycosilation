#!/usr/bin/perl

use strict;

my $F = $ARGV[0] || "./Umaydis_valid_orf_prot_121009";
my $P = $ARGV[1] || "N[^P][STC]";
my %seq;

# Gather proteins
my $id;
my $id_de;
open in, $F;
while (<in>) {
  chomp;

  if (/^\>(.+?)[ :]/) {
    $id = $1;
  } else {
    $seq{$id} .= $_;
  }
}
close in;

# Search patterns
foreach my $um (keys %seq) {
  my $seq = substr $seq{$um}, 0, 14;
  
  my @c = ();
  while ($seq =~ /($P)/ig) {
    push @c, $1;
  }
  if (@c) {
    print "$um\t";
    print $#c + 1, "\t";
    print join ",", @c;
    print "\n";
  }
}
exit;
