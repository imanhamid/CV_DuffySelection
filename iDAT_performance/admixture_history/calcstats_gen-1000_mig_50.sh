#!/bin/bash
#SBATCH -p scavenger
#SBATCH --job-name="gen1000mig50"
#SBATCH -a 1-100
#SBATCH -o "gen-1000_mig-50.out"
#SBATCH --mem=10G

module load R/4.0.0

c=$SLURM_ARRAY_TASK_ID

declare -i c10="${c}0"

for i in {0..9};
do

c_array[$i]=$((c10 - i))

done

for i in "${c_array[@]}"
do
filename=$(ls /work/ih49/simulations/gen-1000_mig-50_s-0/*_seed-${i}_ancestryproportions.csv | head -n 1)
~/home/CV_DuffySelection/Revisions/ancestryanalysis_admixture_history.R $filename > /work/ih49/Rstats/gen-1000_mig-50_s-0/Rstats_${i}.out

filename=$(ls /work/ih49/simulations/gen-1000_mig-50_s-01/*_seed-${i}_ancestryproportions.csv | head -n 1)
~/home/CV_DuffySelection/Revisions/ancestryanalysis_admixture_history.R $filename > /work/ih49/Rstats/gen-1000_mig-50_s-01/Rstats_${i}.out

filename=$(ls /work/ih49/simulations/gen-1000_mig-50_s-05/*_seed-${i}_ancestryproportions.csv | head -n 1)
~/home/CV_DuffySelection/Revisions/ancestryanalysis_admixture_history.R $filename > /work/ih49/Rstats/gen-1000_mig-50_s-05/Rstats_${i}.out

filename=$(ls /work/ih49/simulations/gen-1000_mig-50_s-1/*_seed-${i}_ancestryproportions.csv | head -n 1)
~/home/CV_DuffySelection/Revisions/ancestryanalysis_admixture_history.R $filename > /work/ih49/Rstats/gen-1000_mig-50_s-1/Rstats_${i}.out
done
