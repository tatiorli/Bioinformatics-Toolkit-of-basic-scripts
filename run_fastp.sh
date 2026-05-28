#!/bin/bash
#BSUB -q short
#BSUB -J fastp
#BSUB -o output-%J.o
#BSUB -e error-%J.e
#BSUB -R "rusage[mem=4096]"

# Run the QC "Fastp" on the RNA-seq data raw reads
# Load required modules
module load fastp/0.23.4-GCC-12.2.0

# Path to samples list and config file
SAMPLES_LIST="/home/labs/straussman/tatianas/rna-seq/start_again_2024/fastp/samples.txt"

# Check if the sample list exists
if [ ! -f "$SAMPLES_LIST" ]; then
  echo "Error: Sample list file not found: $SAMPLES_LIST"
  exit 1
fi

# Loop through each sample and submit a job
while IFS= read -r sample; do
  if [ -n "$sample" ]; then
    echo "Submitting job for sample: $sample"
    bsub -q short \
         -J "fastp_$sample" \
         -o "${sample}.o" \
         -e "${sample}.e" \
         -R "rusage[mem=64000]" \
         -N \
         fastp \
         --in1 "/home/labs/straussman/tatianas/rna-seq/start_again_2024/raw_reads/${sample}_R1.fastq.gz" \
         --in2 "/home/labs/straussman/tatianas/rna-seq/start_again_2024/raw_reads/${sample}_R2.fastq.gz" \
         --out1 "/home/labs/straussman/tatianas/rna-seq/start_again_2024/fastp/${sample}_trim_R1.fastq.gz" \
         --out2 "/home/labs/straussman/tatianas/rna-seq/start_again_2024/fastp/${sample}_trim_R2.fastq.gz" \
         --detect_adapter_for_pe \
         -l 30 \
         --disable_length_filtering \
         --disable_quality_filtering \
         --disable_adapter_trimming \
         --thread 16 \
         --json "/home/labs/straussman/tatianas/rna-seq/start_again_2024/fastp/${sample}_fastp.json" \
         --html "/home/labs/straussman/tatianas/rna-seq/start_again_2024/fastp/${sample}_fastp.html"
  fi
done < "$SAMPLES_LIST"

echo "All jobs submitted."

