#!/bin/bash

echo -e "Starting...\n"

bsub -q bio-guest zcat --force  /home/labs/straussman/tatianas/rna-seq/* > /home/labs/straussman/tatianas/rna-seq/all_reads.fastq

echo -e "Done.\n"

