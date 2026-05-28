#!bin/bash

module load kraken2/2.0.8
# First, generate the Braken command line for each file
for f in `ls kraken_*.o | sed 's/kraken_//g' | sed 's/.o//g' | sort -u`;
do
/home/labs/straussman/tatianas/programs/Bracken_software/bracken -d /home/labs/straussman/tatianas/kraken_plusPF_database/ -i kraken_${f}.kreport -o kraken_${f}.bracken -r 100 -l G -t 0
done

# Next you join multiple braken  tables to have one output for all samples in tabular format (summary table):
# Focus on the output named *.bracken and in the column "new_est_reads" - Column 6 
for f in `ls kraken_*.bracken | sed 's/kraken_//g' |  sed 's/.bracken//g' | sort -u`; do cut -f 6 kraken_${f}.bracken >column_$f; done
# Now you just add headers: the first column is the taxa names in list format and the first row is the samples names.
ls kraken_*.bracken | sed 's/kraken_//g' |  sed 's/.bracken//g' | sort -u > headers # This give the list of the samples names
cut -f 1 kraken_TUM44_para.bracken >column_ # This is the taxa names list
# Join it all and then manually transpose and fix the headers.
paste column_* >all
