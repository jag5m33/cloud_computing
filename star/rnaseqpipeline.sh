#!/bin/bash
#SBATCH -p msc_appbio
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --array=0-53
#SBATCH -J RNAseq_STAR
#SBATCH --time=4:00:00
#SBATCH --mem=8G

echo "Start of pipeline"
# Directories
baseDirectory="/scratch/grp/msc_appbio/containersPipelines/svj_grp/E-MTAB-7657/"
fastqDir="${baseDirectory}fastq/"
resultsDirectory="${baseDirectory}results/"

# Create results directory if it doesn't exist
mkdir -p "$resultsDirectory"
chmod 777 "$resultsDirectory"

# Pick FASTQ file for this array task
fastqFile=$(ls ${fastqDir}*.fastq.gz | sed -n "$((SLURM_ARRAY_TASK_ID+1))p")
sampleName=$(basename "$fastqFile" .fastq.gz)
