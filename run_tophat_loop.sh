#!/bin/bash
#BSUB -q new-medium
#BSUB -o output-%J.o
#BSUB -e error-%J.e


module load bowtie2/2.3.5.1
module load tophat/2.1.1

# First, generate the tophat command line for each file
for f in `ls *.fastq | sed 's/.fastq//g' | sort -u`;
do
echo "bsub -q new-medium -J tophat_$f -R "rusage[mem=64000]" -e tophat_$f.e tophat -o tophat_composite_$f human_Salmonella $f.fastq"
done

# Now run all commands  to submit jobs
bsub -q new-medium -J tophat_01 -R "rusage[mem=64000]" -e tophat_01.e tophat -o tophat_composite_01 human_Salmonella 01.fastq
bsub -q new-medium -J tophat_02 -R "rusage[mem=64000]" -e tophat_02.e tophat -o tophat_composite_02 human_Salmonella 02.fastq
bsub -q new-medium -J tophat_03 -R "rusage[mem=64000]" -e tophat_03.e tophat -o tophat_composite_03 human_Salmonella 03.fastq
bsub -q new-medium -J tophat_0405 -R "rusage[mem=64000]" -e tophat_0405.e tophat -o tophat_composite_0405 human_Salmonella 0405.fastq
bsub -q new-medium -J tophat_06 -R "rusage[mem=64000]" -e tophat_06.e tophat -o tophat_composite_06 human_Salmonella 06.fastq
bsub -q new-medium -J tophat_07 -R "rusage[mem=64000]" -e tophat_07.e tophat -o tophat_composite_07 human_Salmonella 07.fastq
bsub -q new-medium -J tophat_08 -R "rusage[mem=64000]" -e tophat_08.e tophat -o tophat_composite_08 human_Salmonella 08.fastq
bsub -q new-medium -J tophat_09 -R "rusage[mem=64000]" -e tophat_09.e tophat -o tophat_composite_09 human_Salmonella 09.fastq
bsub -q new-medium -J tophat_1011 -R "rusage[mem=64000]" -e tophat_1011.e tophat -o tophat_composite_1011 human_Salmonella 1011.fastq
bsub -q new-medium -J tophat_12 -R "rusage[mem=64000]" -e tophat_12.e tophat -o tophat_composite_12 human_Salmonella 12.fastq
