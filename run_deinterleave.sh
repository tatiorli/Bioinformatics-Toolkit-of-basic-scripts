#!/bin/bash


for f in `ls *.fastq | sed 's/final_filtered_file_//g' |  sed 's/.fastq//g' | sort -u`;
do
bash /home/labs/straussman/tatianas/programs/deinterleave_fastq.sh < final_filtered_file_${f}.fastq ${f}_R1.fastq ${f}_R2.fastq
done

