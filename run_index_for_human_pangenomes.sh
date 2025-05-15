#!/bin/bash

# 2024 - Script to generate a STAR index for the human pangenomes in WEXAC
# Important regards: 
# This human pangenomes are the latest version released and downloaded at November 2024 directly from the consortium submissions on NCBI. Same applies for the annotation, tha was downloaded in GTF format.
# The final (Year1 release) genomes ae 47 individuals, all together concatenated in one file: /home/labs/straussman/tatianas/human_pangenomes/Human_Pangenomes_47_releaseY1.fa
# The full annotation file is /home/labs/straussman/tatianas/human_pangenomes/annot/Human_Pangenomes_47_releaseY1.gtf

# Extra: I choose to set the parameter "--sjdbOverhang" to 58 because my RNAseq reads are on average 60 bp after trimming adaptors


# First load the module for STAR with the last version
module load STAR/2.7.11b-GCC-13.2.0


bsub -q short -J STAR_index_pan -o STAR_index_pan.o -e STAR_index_pan.e -R "rusage[mem=64000]" -N \
STAR --runThreadN 20 \
  --runMode genomeGenerate \
  --genomeDir /home/labs/straussman/tatianas/human_pangenomes \
  --genomeFastaFiles /home/labs/straussman/tatianas/human_pangenomes/Human_Pangenomes_47_releaseY1.fa \
  --sjdbGTFfile /home/labs/straussman/tatianas/human_pangenomes/Human_Pangenomes_47_releaseY1.gtf \
  --genomeSAindexNbases 12 \
  --sjdbOverhang 58 \
  --limitGenomeGenerateRAM 386149297077 \
  --genomeSAsparseD 3 \
  --limitIObufferSize 30000000 50000000
