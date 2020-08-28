#!/bin/bash
#SBATCH -p scavenger
#SBATCH -a 1-50
#SBATCH --mem=10G

module load R/4.0.0

c=$SLURM_ARRAY_TASK_ID

~/home/CV_DuffySelection/globalancestry_sims/run_SLiM_globalancestry.R --seed=${c}\
 -m 0.65 --s_low=0 --s_high=0.2 --unif_recomb\
 -o /work/ih49/simulations/globalancestry/whole_autosome/\
 --slim_dir=/hpc/home/ih49/home/SLiM_build/slim\
 --slim_model=/hpc/home/ih49/home/CV_DuffySelection/globalancestry_sims/exp-05-10000_single-pulse_whole-autosome.slim
