#!/bin/bash

# Path to your list of FASTQ files
LIST="list_of_fastq_files_to_zip.txt"

# Loop over each file in the list
while IFS= read -r fastq_file; do
    # Get the base name (e.g., STAR_TUM11_S13_unmapped_reads_R1.fastq)
    base_name=$(basename "$fastq_file")

    # Name for the job
    job_name="zip_${base_name%.fastq}"

    # Submit a job to compress the file with pigz
    bsub -J "$job_name" -n 1 -R "rusage[mem=2000]" -oo "logs/${job_name}.out" -eo "logs/${job_name}.err" "
        module load pigz || true
        pigz -p 4 \"$fastq_file\"
    "
done < "$LIST"
