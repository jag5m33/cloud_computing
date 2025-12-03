#!/bin/bash
#SBATCH -p msc_appbio
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --array=0-53
#SBATCH -J RNAseq_STAR
#SBATCH --time=4:00:00
#SBATCH --mem=8G

echo "Start of pipeline"
