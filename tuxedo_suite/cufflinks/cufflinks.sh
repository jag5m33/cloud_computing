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
GTF=/scratch/grp/msc_appbio/containersPipelines/svj_grp/E-MTAB-7657_clean/yeast
Genome/Saccharomyces_cerevisiae.R64-1-1.110.NCnames.gtf
MASK=/scratch/grp/msc_appbio/containersPipelines/svj_grp/E-MTAB-7657_clean/yeas
tGenome/rRNA_mask.gtf
OUTDIR=/scratch/grp/msc_appbio/containersPipelines/svj_grp/E-MTAB-7657_clean/ye
astGenome/cufflinks_out
BAMDIR=/scratch/grp/msc_appbio/containersPipelines/svj_grp/E-MTAB-7657_clean/to
phat_results

mkdir -p $OUTDIR
