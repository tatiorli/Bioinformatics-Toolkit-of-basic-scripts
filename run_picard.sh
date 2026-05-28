#!/bin/bash

module load picard/2.25.1-Java-11

bsub -n 6 -q new-short -J fastqtobam java -jar $EBROOTPICARD/picard.jar FastqToSam FASTQ=TUM46_S36_R_trim_R1.fastq FASTQ2=TUM46_S36_R_trim_R2.fastq OUTPUT=TUM46_trim_R.sam READ_GROUP_NAME=A00929 SAMPLE_NAME=TUM46 LIBRARY_NAME=Illumina PLATFORM=illumina

