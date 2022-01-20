#!/bin/bash
#
#SBATCH --job-name=cuda-reconstruct
#SBATCH --gres=gpu:1
#SBATCH --time=00:01:00
#SBATCH --partition=gpu-cascade
#SBATCH --qos=gpu

NVHPC_VERSION=21.2
module load nvidia/nvhpc/$NVHPC_VERSION

cmd=(
    ncu
    -o reconstruct-ncu-${SLURM_JOB_ID} # save to file
    --kernel-regex '.*inverseEdgeDetect.*' # specify kernel to allow skip and count
    --launch-skip 1 # skip first one as cold
    --launch-count 10 # collect only ten runs (as collecting detailed info)
    --set detailed # collect 
    reconstruct # application
)
"${cmd[@]}"
