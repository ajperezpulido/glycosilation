#!/usr/bin/perl

use strict;

my $F = $ARGV[0] || "./Umaydis_valid_orf_prot_121009";
my $W = $ARGV[1] || 40; # window size
my $ST = $ARGV[2] /100 || 0.4; # percentage [ST]
my %seq;

# Gather transmembranes
my %tm;
open in, "./um_transmembrane.txt";
while (<in>) {
  chomp $_;

  my ($id, $de) = (split /\t/)[1,4];
  next if $de =~ /GPI/; # REVIEW
  $tm{$id} = 1;
}
close in;

# Gather proteins
my $id;
open in, $F;
while (<in>) {
  chomp;

  #if (/^\>(um\d+|.+?_USTMA)(\s|\t)/) {
  if (/^\>(.+?)(\s|\t)/) {
    $id = $1;
  } else {
    #next unless ($tm{$id}); # Filter YES/NO
    $seq{$id} .= $_;
  }
}
close in;

# Search ST windows
foreach my $um (keys %seq) {
  my $hit; # hit=1 if window with good [ST]
  my $seq = $seq{$um};
  my $len = length $seq;

  for (my $x = 0; $x <= $len-$W; $x++) {
    my $w = substr $seq, $x, $W;

    next if $w =~ /0/;
    my $st= ($w =~ s/[ST]//g) / $W;
    
    if ($st >= $ST) {
      my $p1 = $x + 1;
      my $p2 = $x + $W;
      $hit = $p1 . "-" . $p2 . "\t$st";
      last;
    }
  }
  print "$um\t$hit\n" if $hit;
}

exit;
