#!/usr/bin/perl -w
use 5.010;
# Read a reference list of peptides and generate an out file with peptides counts combined in the same order of your reference list. If hte peptide is absent, print 0
my ($reference_list_file, $counts_file, $output_filename) = @ARGV;

if (not defined $reference_list_file) {
  die "Attention: Usage: peptide_count_files_stats.pl <input reference filename> <counts peptides file> <output filename>\n";
}

if (not defined $counts_file) {
  die "Attention: Usage: peptide_count_files_stats.pl <input reference filename> <counts peptides file> <output filename>\n";
}

if (not defined $output_filename) {
  die "Attention: Usage: peptide_count_files_stats.pl <input reference filename> <counts peptides file> <output filename>\n";
}

unless( open(REFERENCE_DATA, $reference_list_file) ) {
  print STDERR "Cannot open file \"$reference_list_file\"\n\n";
  exit;
}

unless( open(COUNTS_DATA, $counts_file) ) {
  print STDERR "Cannot open file \"$counts_file\"\n\n";
  exit;
}

if (defined $output_filename){
    unless ( open(FILEOUT, ">$output_filename") ) {
	die "Could not create \"$output_filename\" to save results: $!\n\n";
    }
}

my @peptides_reference_list = (  );
@peptides_reference_list = <REFERENCE_DATA>;
close REFERENCE_DATA;

my @peptides_and_counts = (  );
@peptides_and_counts = <COUNTS_DATA>;
close COUNTS_DATA;

my %peptides_and_counts_hash;
foreach my $line (@peptides_and_counts) {
	$line =~ m/(\D+):/;
	my $peptide = $1;
	chop $peptide;
	$line =~ m/(\d+)/;
	my $count = $1;
	$peptides_and_counts_hash{$peptide} = $count;
}

foreach my $ref_pep (@peptides_reference_list){
	chomp $ref_pep;
	if (exists $peptides_and_counts_hash{$ref_pep}) {
		print FILEOUT "$peptides_and_counts_hash{$ref_pep}\n";
		#print FILEOUT "the ref($ref_pep) matched the peptide in the count file and count = $peptides_and_counts_hash{$ref_pep}\n";
	} else {
		print FILEOUT "0\n";
		#print FILEOUT "the ref($ref_pep) not matched any peptide and count = 0\n";
	}
}

print "Done.\n";
close(FILEOUT);
exit;
