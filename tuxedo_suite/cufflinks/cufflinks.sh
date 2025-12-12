#!/bin/bash
#SBATCH --job-name=cufflinks
#SBATCH --output=cufflinks.out
#SBATCH --error=cufflinks.err
#SBATCH --cpus-per-task=8
#SBATCH --time=08:00:00
#SBATCH --partition=cpu
source ~/miniconda3/etc/profile.d/conda.sh
conda activate tophat_env

# Set paths
GTF=/scratch/grp/msc_appbio/containersPipelines/svj_grp/E-MTAB-7657_clean/yeastGenome/Saccharomyces_cerevisiae.R64-1-1.110.NCnames.gtf
MASK=/scratch/grp/msc_appbio/containersPipelines/svj_grp/E-MTAB-7657_clean/yeastGenome/rRNA_mask.gtf
OUTDIR=/scratch/grp/msc_appbio/containersPipelines/svj_grp/E-MTAB-7657_clean/cufflinks_out # output directory where the FPKM files are saved)
BAMDIR=/scratch/grp/msc_appbio/containersPipelines/svj_grp/E-MTAB-7657_clean/tophat_results

mkdir -p $OUTDIR

# Loop over all BAM files from the tophat_results directories 
for BAM in $BAMDIR/*/accepted_hits.bam; do # for loop to iterate over all 54 fastq files
  # the */accepted_hits.bam implies the file name changes in the tophat_results directory but the .bam file name does not
    SAMPLE=$(basename $(dirname $BAM))
    SAMPLE_OUT=$OUTDIR/$SAMPLE # save the output sample in another directory called cufflinks_out (mentioned in file pathways)&create another direcotry with the file name and label
    mkdir -p $SAMPLE_OUT # create output directory of sample name in the output directory: cufflinks_out
    
    #cufflinks script 
    cufflinks \  
      # quantification: upper quartile normalisation - mentioned in the paper
      --upper-quartile-norm \
      #create mask file earlier: rRNA_mask.gtf to ignore noise
      --mask-file $MASK \
      # reference genome
      -G $GTF \
      #use 8 cpue threads
      -p 8 \
      #output directory for output FPKM files
      -o $SAMPLE_OUT \
      $BAM
done
