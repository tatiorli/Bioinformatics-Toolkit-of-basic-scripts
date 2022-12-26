#!/usr/bin/perl -w
use strict;
use warnings;
use Getopt::Long;

my $total_count = 0;
my $average = 0;
my @sizes;

my($help, $inputfile, $outputfile, $N);

GetOptions ("h|help" => \$help, "i=s" => \$inputfile, "o=s" => \$outputfile, "N=i" => \$N);
if (!$inputfile){
  print 
"\n##### N50 Program - version 1.1 (c) 2014 Tatiana Orli #####

Welcome to N50 calculator program. It calculates N50 or any other N-value according to the user's choice,
using a multiple sequence FASTA file (assembly) as an input. In addition to the N-value, it provides the following infomation: 
total number of bases, number of contigs, average number of bases per contig, longest contig and shortest contig.

Usage:

N50Calculator.pl [-i inputfile] [-o outputfile] [-N integer] 

Example:

N50Calculator.pl -i my_sequences_assembly.fasta -o output_file_for_statistics -N 90

Options:
The order of options is irrelevant.

-i		Input FASTA file of an assembly, not reads, mandatory;
-o		Output file (optional)
-N		[user's N-value]: default = 25, 50 and 75
-help or -h	[show this parameter list]

\n";
  exit;
}

### print Help
my $help_print = "\n##### N50 Program - version 1.1 (c) 2014 Tatiana Orli #####

Welcome to N50 calculator program. It calculates N50 or any other N-value according to the user's choice,
using a multiple sequence FASTA file (assembly) as an input. In addition to the N-value, it provides the following infomation: 
total number of bases, number of contigs, average number of bases per contig, longest contig and shortest contig.

Usage:

N50Calculator.pl [-i inputfile] [-o outputfile] [-N integer] 

Example:

N50Calculator.pl -i my_sequences_assembly.fasta -o output_file_for_statistics -N 90

Options:
The order of options is irrelevant.

-i		Input FASTA file of an assembly, not reads, mandatory;
-o		Output file (optional)
-N		[user's N-value]: default = 25, 50 and 75
-help or -h	[show this parameter list]

\n";

### Get command line options
if ($help){
    print "$help_print";
    exit;
}

open (INPUTFILE,"$inputfile")
  or die "Could not open file $inputfile: $!\n";

print "\n---------------- Information for assembly \'$inputfile\' ----------------\n\n";
# Count the number of bases, number of contigs and store sequences in an array (@lines)
my $old_delimiter = $/ ;
$/ =">";
<INPUTFILE>;
#
while (my $one_contig = <INPUTFILE>){
  #
  #we just read the whole contig, minus the leading ">", plus the next ">", if it exists
  #
  chomp($one_contig); 
  my @lines = split("\n", $one_contig);
  #
  #take out fasta header
  #
  shift(@lines);
  my $only_bases = join("",@lines);
  $only_bases =~ s/\s//g;
  my $number_bases =  length($only_bases);
  push(@sizes,$number_bases);
  $total_count += $number_bases;
}
#
# Now that all sequences were read, can compute statistics
#
$/ = $old_delimiter;  
close(INPUTFILE);
# Now sort the sizes, so we can scan them and find n50, n30, or whichever was requested
#
my  @sorted_sizes = sort {$b <=> $a}(@sizes);   

my $number_of_contigs = @sorted_sizes; 

# Calculate N value requested by the user, and the Default N-values ( 25, 50, 75)
my @n_values = ('0.25', '0.5', '0.75');
my @results;
my $aux_count;

if(defined $N && $N != 50 && $N != 75 && $N != 25) {
    $N = $N/100;
    unshift @n_values, $N;
}

foreach my $value (@n_values){
    foreach  my $one_size (@sorted_sizes){
	#get one size, update base count with the size
	$aux_count += $one_size;
 	#if nfactor was reached, print AND exit loop (no need to keep looking)
        #
	if ($aux_count >= $total_count * $value){
	    push(@results,$one_size);
	    $aux_count = 0;
	    last; #exiting loop.
	}
    }
}

# Calculate the average number of bases per contig
$average = $total_count / $number_of_contigs;

if ($average =~ /(\d+\.\d{0,2}).*/){
  $average = $1;
}

# Get the longest and shortest sequences
my $max = shift(@sorted_sizes);
my $longest = "Longest contig = $max";
	
my $min = pop(@sorted_sizes);		
my $shortest = "Shortest contig = $min";
	
# Now print everything, or send it to an outside file
# For loop to print all the N-values calculated
for (my $i=0; $i < scalar(@results); $i++) {
    my $N_value = $n_values[$i]*100;
    print "N$N_value stats = $results[$i]\n"
}

print "$longest\n";
print "$shortest\n";
print "Number of bases: $total_count\n";
print "Number of contigs: $number_of_contigs\n";
print "Average number of bases per contig: $average\n";

if (defined $outputfile){

    unless ( open(FILEOUT, ">$outputfile") ) {
	die "Could not create \"$outputfile\" to save results: $!\n\n";
    }

    print FILEOUT "
---------------- Information for assembly \'$inputfile\' ----------------\n\n";

# for loop to print the N-values 
for (my $i=0; $i < scalar(@results); $i++) {
	my $N_values = $n_values[$i]*100;
	print FILEOUT "N$N_values stats = $results[$i]\n";
}
    print FILEOUT "$longest
$shortest
Number of bases: $total_count
Number of contigs: $number_of_contigs
Average number of bases per contig: $average\n";

    close(FILEOUT);

    exit;
}
