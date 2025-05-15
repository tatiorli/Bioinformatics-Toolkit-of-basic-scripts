#!/bin/bash
# November 2024
# The pangenomes consortia has already published 47 samples (individuals) totalizing 47 full genomes, with 2 haplotypes per genome (maternal and paternal).
# I need to fetch them all from NCBI using a loop of wgets

# Define the URLs to be downloaded
urls=(
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG00438/assemblies/year1_freeze_assembly_v3/HG00438.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG00621/assemblies/year1_freeze_assembly_v3/HG00621.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG00673/assemblies/year1_freeze_assembly_v3/HG00673.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG00735/assemblies/year1_freeze_assembly_v3/HG00735.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG00741/assemblies/year1_freeze_assembly_v3/HG00741.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG01071/assemblies/year1_freeze_assembly_v3/HG01071.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG01106/assemblies/year1_freeze_assembly_v3/HG01106.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG01123/assemblies/year1_freeze_assembly_v3/HG01123.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG01175/assemblies/year1_freeze_assembly_v3/HG01175.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG01258/assemblies/year1_freeze_assembly_v3/HG01258.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG01358/assemblies/year1_freeze_assembly_v3/HG01358.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG01361/assemblies/year1_freeze_assembly_v3/HG01361.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG01891/assemblies/year1_freeze_assembly_v3/HG01891.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG01928/assemblies/year1_freeze_assembly_v3/HG01928.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG01952/assemblies/year1_freeze_assembly_v3/HG01952.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG01978/assemblies/year1_freeze_assembly_v3/HG01978.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG02148/assemblies/year1_freeze_assembly_v3/HG02148.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG02257/assemblies/year1_freeze_assembly_v3/HG02257.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG02486/assemblies/year1_freeze_assembly_v3/HG02486.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG02559/assemblies/year1_freeze_assembly_v3/HG02559.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG02572/assemblies/year1_freeze_assembly_v3/HG02572.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG02622/assemblies/year1_freeze_assembly_v3/HG02622.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG02630/assemblies/year1_freeze_assembly_v3/HG02630.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG02717/assemblies/year1_freeze_assembly_v3/HG02717.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG02886/assemblies/year1_freeze_assembly_v3/HG02886.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG03453/assemblies/year1_freeze_assembly_v3/HG03453.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG03516/assemblies/year1_freeze_assembly_v3/HG03516.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG03540/assemblies/year1_freeze_assembly_v3/HG03540.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG03579/assemblies/year1_freeze_assembly_v3/HG03579.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG002/assemblies/year1_freeze_assembly_v3/HG002.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG005/assemblies/year1_freeze_assembly_v3/HG005.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG00733/assemblies/year1_freeze_assembly_v3/HG00733.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG01109/assemblies/year1_freeze_assembly_v3/HG01109.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG01243/assemblies/year1_freeze_assembly_v3/HG01243.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG02055/assemblies/year1_freeze_assembly_v3/HG02055.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG02080/assemblies/year1_freeze_assembly_v3/HG02080.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG02109/assemblies/year1_freeze_assembly_v3/HG02109.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG02145/assemblies/year1_freeze_assembly_v3/HG02145.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG02723/assemblies/year1_freeze_assembly_v3/HG02723.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG02818/assemblies/year1_freeze_assembly_v3/HG02818.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG03098/assemblies/year1_freeze_assembly_v3/HG03098.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG03486/assemblies/year1_freeze_assembly_v3/HG03486.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/HG03492/assemblies/year1_freeze_assembly_v3/HG03492.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/NA18906/assemblies/year1_freeze_assembly_v3/NA18906.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/NA19240/assemblies/year1_freeze_assembly_v3/NA19240.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/NA20129/assemblies/year1_freeze_assembly_v3/NA20129.paternal.f1_assembly_v2.fa.gz"
    "https://human-pangenomics.s3.amazonaws.com/submissions/4CE43AFC-BA7F-480F-B073-8A0C303E9DAB--YEAR_1_ASSEMBLIES_V3/NA21309/assemblies/year1_freeze_assembly_v3/NA21309.paternal.f1_assembly_v2.fa.gz"
)

# Loop through the URLs and submit each command with bsub
for url in "${urls[@]}"; do
    bsub -J "wget_job" -o "wget_output_%J.txt" "wget $url"
done
