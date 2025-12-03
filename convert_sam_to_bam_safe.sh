#!/bin/bash

LIST="list_of_sam_files.txt"
FAILED_LIST="failed_sam_conversion.txt"

# Create logs dir if missing
mkdir -p logs

# Remove previous failed list
rm -f "$FAILED_LIST"

while IFS= read -r sam_file; do
    [ -z "$sam_file" ] && continue

    base_name=$(basename "$sam_file")
    prefix="${base_name%.sam}"
    dir_name=$(dirname "$sam_file")

    job_name="sam2bam_${prefix}"

    # Temporary per-job failed list to avoid race conditions
    tmp_failed="tmp_failed_${prefix}.txt"

    bsub -J "$job_name" -n 1 -R "rusage[mem=4000]" \
        -oo "logs/${job_name}.out" \
        -eo "logs/${job_name}.err" \
        "
        module load SAMtools/1.21-GCC-13.2.0 || true

        # --- 1. HEADER CHECK ---
        if ! grep -q '^@' \"$sam_file\"; then
            echo \"$sam_file\" > \"$tmp_failed\"
            echo \"No SAM header found — marking as failed.\"
            exit 1
        fi

        # --- 2. SAMTOOLS CHECK + CONVERSION ---
        samtools view -S -b \"$sam_file\" > \"${dir_name}/${prefix}.bam\"
        if [ $? -ne 0 ]; then
            echo \"$sam_file\" > \"$tmp_failed\"
            echo \"samtools view failed — marking as failed.\"
            exit 1
        fi

        # --- 3. SORT ---
        samtools sort -o \"${dir_name}/${prefix}.sorted.bam\" \"${dir_name}/${prefix}.bam\"
        if [ $? -ne 0 ]; then
            echo \"$sam_file\" > \"$tmp_failed\"
            echo \"samtools sort failed — marking as failed.\"
            exit 1
        fi

        samtools index \"${dir_name}/${prefix}.sorted.bam\"

        # Cleanup intermediate BAM
        rm \"${dir_name}/${prefix}.bam\"

        # --- 4. SAFE DELETE OF SAM ---
        if [ -s \"${dir_name}/${prefix}.sorted.bam\" ]; then
            rm \"$sam_file\"
        else
            echo \"$sam_file\" > \"$tmp_failed\"
            echo \"Empty or missing BAM — SAM kept, marking as failed.\"
            exit 1
        fi

        "
done < "$LIST"

