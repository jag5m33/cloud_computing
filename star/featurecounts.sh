#!/bin/bash
#SBATCH -p msc_appbio
#SBATCH -J featurecounts
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --output=featurecounts.out
#SBATCH --error=featurecounts.err

basedir="/scratch/grp/msc_appbio/containersPipelines/svj_grp/E-MTAB-7657"
resultsdir="$basedir/results"
gff="$basedir/yeastGenome/yeast.gff"
container="$basedir/subread_latest.sif"

echo "Detected gene attribute: ID"

singularity exec --no-fuse --bind "$basedir":"$basedir" "$container" \
    featureCounts -T 4 -g ID -a "$gff" \
    -o "$basedir/counts.txt" $resultsdir/*.bam

echo "featureCounts finished."
