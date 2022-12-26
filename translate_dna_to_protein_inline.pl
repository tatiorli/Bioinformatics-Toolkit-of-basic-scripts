#!/usr/bin/perl -w
use strict;
use lib '/home/tatiana/workspace';
use warnings;
use BeginPerlBioinfo;

# Example 8-1   Translate DNA into protein

# Initialize variables
my $dna = 'CGACGTCTTCGTACGGGACTAGCTCGTGTCGGTCGC';
my $protein = '';
my $codon;

# Translate each three-base codon into an amino acid, and append to a protein 
for(my $i=0; $i < (length($dna) - 2) ; $i += 3) {
    $codon = substr($dna,$i,3);
    $protein .= codon2aa($codon);
}

print "I translated the DNA:\n\n$dna\n\ninto the protein:\n\n$protein\n\n";

exit;
