#!/bin/bash
#SBATCH --job-name=cuffdiff_${1}vs${2}
#SBATCH --output=cuffdiff_%j.out
#SBATCH --error=cuffdiff_%j.err
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=08:00:00

# Load conda environment instead of modules
source ~/.bashrc
conda activate /users/k22031154/miniconda3/envs/tophat_env

SDRF="E-MTAB-7657.sdrf.txt"
TOPHAT_DIR="tophat_results"
GTF="yeastGenome/Saccharomyces_cerevisiae.R64-1-1.110.NCnames.g>

TP1=$1
TP2=$2

# Check arguments
if [[ -z "$TP1" || -z "$TP2" ]]; then
    echo "Error: You must provide two timepoints (e.g. sbatch c>
    exit 1
fi

declare -A T1
declare -A T2

while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6 col7 col8>
                        col11 col12 col13 col14 col15 col16 col>
                        col21 col22 col23 col24 col25 col26 col>
do
    if [[ "$run" == "Comment[ENA_RUN]" ]]; then
        continue
    fi

    bam_path="${TOPHAT_DIR}/${run}/accepted_hits.bam"

    if [[ ! -f "$bam_path" ]]; then
        echo "WARNING: Missing BAM for $run"
        continue
    fi

    [[ "$time" == "$TP1" ]] && T1["$run"]="$bam_path"
    [[ "$time" == "$TP2" ]] && T2["$run"]="$bam_path"

done < "$SDRF"

JOIN1=$(printf ",%s" "${T1[@]}")
JOIN1=${JOIN1:1}

# Check if BAMs exist
if [[ -z "$JOIN1" ]]; then
    echo "Error: No BAMs found for timepoint $TP1"
    exit 1
fi
if [[ -z "$JOIN2" ]]; then
    echo "Error: No BAMs found for timepoint $TP2"
    exit 1
fi

OUTDIR="cuffdiff_${TP1}vs${TP2}"
cuffdiff -o "$OUTDIR" -p $SLURM_CPUS_PER_TASK -L ${TP1}h,${TP2}
echo "Comparison $TP1 vs $TP2 complete."
