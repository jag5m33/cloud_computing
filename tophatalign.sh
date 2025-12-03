#!/bin/bash
#SBATCH --job-name=tophat_align
#SBATCH --output=tophat_results/logs/tophat_%A_%a.out
#SBATCH --error=tophat_results/logs/tophat_%A_%a.err
#SBATCH --time=12:00:00
#SBATCH --mem=16G
#SBATCH --cpus-per-task=4
#SBATCH --array=1-54
