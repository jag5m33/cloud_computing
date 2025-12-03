#!/bin/bash
#SBATCH --job-name=tophat_align
#SBATCH --output=tophat_results/logs/tophat_%A_%a.out
#SBATCH --error=tophat_results/logs/tophat_%A_%a.err
#SBATCH --time=12:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --array=1-54

# Load your environment
module load miniconda3
source activate tophat_env


# Path to your FASTQ files
FASTQ_DIR=/scratch/grp/msc_appbio/containersPipelines/svj_grp/E-MTAB-7657_clean/fastq
GENOME_INDEX=/scratch/grp/msc_appbio/containersPipelines/svj_grp/E-MTAB-7657_clean/yeastGenomeIndex_bowtie2/yeast
GTF_FILE=/scratch/grp/msc_appbio/containersPipelines/svj_grp/E-MTAB-7657_clean/yeastGenome/Saccharomyces_cerevisiae.R64-1-1.110.NCnam
es.gtf
OUTPUT_DIR=/scratch/grp/msc_appbio/containersPipelines/svj_grp/E-MTAB-7657_clean/tophat_results

# Get the filename corresponding to the SLURM_ARRAY_TASK_ID
FASTQ_FILE=$(ls $FASTQ_DIR/*.fastq.gz | sed -n "${SLURM_ARRAY_TASK_ID}p")
BASENAME=$(basename $FASTQ_FILE .fastq.gz)

# Make output directory for this sample
mkdir -p $OUTPUT_DIR/$BASENAME

# Run TopHat
tophat -G $GTF_FILE -o $OUTPUT_DIR/$BASENAME $GENOME_INDEX $FASTQ_FILE
