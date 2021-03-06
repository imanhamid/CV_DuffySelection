# CV_DuffySelection

## Citation

Hamid, I., Korunes, K. L., Beleza, S., & Goldberg, A. (2021). Rapid adaptation to malaria facilitated by admixture in the human population of Cabo Verde. *eLife*, 10, e63177. https://doi.org/10.7554/eLife.63177

## Contents
1. Datasets
2. Figure markdowns
3. Neutral simulations
4. _iDAT_ performance simulations
5. SWIF(r) simulations
6. ABC simulations
7. Global ancestry simulations
8. General use simulation scripts

##  Software used
### SLiM

SLiM v3.4 https://messerlab.org/slim/

### Python libraries for manipulating trees files

pyslim v0.401 https://github.com/tskit-dev/pyslim

msprime v0.7.4 https://msprime.readthedocs.io/

### R package for ABC

abc v2.1 https://cran.r-project.org/web/packages/abc/index.html

### SWIF(r)

SWIF(r) Version 1 https://github.com/ramachandran-lab/SWIFr

## 1. Datasets

[./datasets/](./datasets/) - directory containing simulated datasets used for analyses and observed ancestry-based stats calculated for Cabo Verde islands.

## 2. Figure markdowns

[./figure_md/](./figure_md/) - directory containing markdowns including Rscripts to generate all figures. Also includes code for main analyses performed in this study (see [./figure_md/README.md](./figure_md/README.md) for more detailed descriptions).

* Calculation of observed ancestry-based statistics for Cabo Verde population, including _iDAT_ scores.
  * [./figure_md/CV_EmpiricalAnalyses.md](./figure_md/CV_EmpiricalAnalyses.md)
  * Publication figures 1 & 2, figure 1 supplements 1 & 2, and figure 2 supplement 1
* Comparison of observed Cabo Verde ancestry-based statistics to neutral expectations
  * [./figure_md/NeutralSims.md](./figure_md/NeutralSims.md)
  * Publication figure 2 supplements 2 & 3
* Performance of _iDAT_ under different admixture histories
  * [./figure_md/iDAT_performance.md](./figure_md/iDAT_performance.md)
  * Publication figure 2 supplements 4 & 5
* Validation of SWIF(r) implementation
  * [./figure_md/SWIFr_validation.md](../figure_md/SWIFr_validation.md)
  * Publication figure 6 and figure 6 supplement 1
* ABC estimation of selection strength and source population admixture contribution
  * [./figure_md/ABC.md](./figure_md/ABC.md)
  * Publication figures 4 supplements 1 & 2
* Deterministic population genetic model of single-locus selection
  * [./figure_md/SelectionStrength.md](./figure_md/SelectionStrength.md)
  * Publication figure 4
* Effect of single-locus selection on global ancestry patterns
  * [./figure_md/GlobalAncestry.md](./figure_md/GlobalAncestry.md)
  * Publication figures 5 and figure 5 supplement 1

## 3. Neutral simulations

[./neutral_sims/](./neutral_sims/) - directory containing bash scripts used to generate neutral simulations from 8 different demographic scenarios (see [./neutral_sims/README.md](./neutral_sims/README.md)), extract ancestry information from output files, and calculate ancestry-based statistics used in other analyses.

## 3. _iDAT_ performance simulations

[./iDAT_performance/](./iDAT_performance/) - directory containing bash scripts used to generate simulations from 36 different demographic and selection scenarios, and 4 different chromosome sizes (see [./iDAT_performance/README.md](./iDAT_performance/README.md)), extract ancestry information from output files, and calculate ancestry-based statistics used in other analyses.

## 4. SWIF(r) simulations

[./SWIFr_sims/](./SWIFr_sims/) - directory containing bash scripts used to generate neutral and selection simulations, extracting ancestry information, and calculate ancestry-based statistics for training SWIF(r).

## 5. ABC simulations

[./ABC_sims/](./ABC_sims/) - directory containing bash scripts used to generate sweep simulations, extracting ancestry information, and calculate ancestry-based statistics for ABC estimation of starting admixture proportion and selection coefficient.

## 6. Global ancestry simulations

[./globalancestry_sims/](./globalancestry_sims/) - directory containing bash scripts used to generate whole autosome and two chromosome simulations, extract ancestry information, and calculate global ancestry statistics.

## 7. General use simulation scripts

Current directory contains scripts for generating and analyzing SLiM simulations.

* **admixture.slim** - programmable SLiM script for single-chromosome (modeled after human chromosome 1), two-way admixture simulations with one variant (can be neutral or under selection) at the Duffy-null SNP position (chr1:159174683; GRCh37 coordinates in accordance with genetic map) that is fixed in source population P1. The simulation runs for 20 generations then outputs a .trees file in the specified directory. **The following parameters must be specified:**

  * selection coefficient (s)
  * P1 admixture contribution in generation 1 (mig)
  * admixed population initial size (N)
  * dominance coefficient for modeled Duffy-null SNP (h)
  * population growth rate (rate)
  * admixture type (continuous admixture at rate of 1% new migrants per generation or single-pulse) (cont_adm=T|F)
  * genetic map file (ratesfile)

  **Example usage:** 
  ```
  /path/to/SLiM_build/slim -d s=0.01 -d mig=0.65 \
  -d N=10000 -d h=0.5 -d rate='"05"' -d cont_adm=F \
  -d ratesfile='"/path/to/genetic_map.txt"' \
  -d out='"/path/to/out_directory/name_of_file"' \
  /path/to/admixture.slim
  ```
  This example run will output a "name_of_file.trees" file in the designated out_directory for a simulation with the following scenario: 

  <table>
     <thead>
         <tr>
             <th align="center">initial population size (N)</th>
             <th align="center">population growth model</th>
             <th align="center">population growth rate (per gen)</th>
             <th align="center">admixture type</th>
             <th align="center">proportion of new migrants (per gen)</th>
             <th align="center">P1 initial ancestry contribution</th>
             <th align="center">selection coefficient (s)</th>
         </tr>
     </thead>
     <tbody>
         <tr>
             <td align="center">10000</td>
             <td align="center">exponential</td>
             <td align="center">0.05</td>
             <td align="center">single-pulse</td>
             <td align="center">-</td>
             <td align="center">0.65</td>
             <td align="center">0.01</td>
         </tr>
     </tbody>
  </table>

* **run_SLiM.R** - Rscript to run 10 replicates of SLiM simulations. Can randomly draw admixture contribution and selection coefficient from uniform distribution or set at constant value.

  **Example usage:**
  ```
  /path/to/run_SLiM.R --seed=1 -N 10000 \
  --mig_unif --mig_low=0.1 --mig_high=0.9 --s_unif \
  --s_low=0 --s_high=0.2 -d 0.5 --exp -r 05 \
  -o /path/to/out_directory/ \
  --genetic_map=/path/to/genetic_map.txt \
  --slim_dir=/path/to/SLiM_build/slim \
  --slim_model=/path/to/admixture.slim
  ```
  This will output 10 .trees files (seeds 1-10) for the following scenario:
  
    <table>
     <thead>
         <tr>
             <th align="center">initial population size (N)</th>
             <th align="center">population growth model</th>
             <th align="center">population growth rate (per gen)</th>
             <th align="center">admixture type</th>
             <th align="center">proportion of new migrants (per gen)</th>
             <th align="center">P1 initial ancestry contribution</th>
             <th align="center">selection coefficient (s)</th>
         </tr>
     </thead>
     <tbody>
         <tr>
             <td align="center">10000</td>
             <td align="center">exponential</td>
             <td align="center">0.05</td>
             <td align="center">single-pulse</td>
             <td align="center">-</td>
             <td align="center">m~U(0.1,0.9)</td>
             <td align="center">s~U(0,0.2)</td>
         </tr>
     </tbody>
  </table>
  
  The output names will be "/path/to/out_directory/exp-05-10000_single-pulse_h-0.5_m-X.X_s-X.X_seed-X.trees" with X representing the parameters for that specific run.
  
* **localancestry_proportions.py** - Python script to calculate local ancestry proportion across the simulated genome from .trees files from two-way admixture simulations. Based on Python script for tracking P2 local ancestry along the simulated genome that is provided in recipe 17.5 of SLiM manual. (http://benhaller.com/slim/SLiM_Manual.pdf).

  **Example usage:**
  ```
  /path/to/localancestry_proportions.py /path/to/simulation_name.trees
  ```
  This will output a simulation_name_ancestryproportions.csv file in the same directory as the simulation_name.trees with P2 local ancestry proportion along the genome.
  
  * **localancestry_proportions_sample.py** first samples 172 random individuals before calculating local ancestry along the genome. Usage is the same.
  
* **localancestry_tracts.py** - Python script to extract tract length-based features from .trees files from two-way admixture simulations. This script assumes only one chromosome and one variant was simulated in the SLiM simulation.

  **Example usage:**
  ```
  /path/to/localancestry_tracts.py /path/to/simulation_name.trees
  ```
  This will output a simulation_name_tractlengths.txt file in the same directory as the simulation_name.trees. 
  
  **localancestry_tracts_sample.py** first samples 172 random individuals before extracting tract length-based features for the 344 sampled chromosomes. Usage is the same. Output file will be named simulation_name_tractlengths_sample.txt
  
  The output file will include for each simulated chromosome in the population: 
  * tract_length: the length of the ancestry tract spanning the variant of interest
  * tract_start, tract_end: the start and end positions of that tract, respectively
  * anc: the source population (P1 or P2) ancestry for that tract
  * switches: the number of ancestry switches across the chromosome
  * global_ancestry: the total proportion of P1 or P2 ancestry for the chromosome depending on which source population contributed ancestry at the site of interest
  * child: the ID corresponding to that simulated chromosome
  
* **ancestryanalysis_CV.R** - Rscript to calculate ancestry-based statistics from simulation_name_ancestryproportions.csv and simulation_name_tractlengths.txt files. Assumes simulations were modeled after human chromosome 1, with a single variant at the Duffy-null SNP position. Requires both ancestry proportion and tract length files to be in the same directory following the same naming scheme. Will calculate statistics and print to stdout.

  **Example usage:**
  ```
  /path/to/ancestryanalysis_CV.R /path/to/simulation_name_ancestryproportions.csv
  ```
  **ancestryanalysis_CV_sample.R** is the same script, but assumes the name of the ancestry proportions and tract lengths files include \_sample before the file extension. Usage is the same.
  
  This will output the following parameters and statistics (in order): 
  
  * seed
  * selection coefficient
  * P1 initial admixture contribution
  * percentile rank of P1 local ancestry proportion at the variant of interest
  * P1 local ancestry proportion at the variant of interest
  * mean chromosome-wide P1 ancestry
  * variance in P1 local ancestry proportion along the chromosome
  * variance in P1 local ancestry proportion in the 10Mb window surrounding the site of interest
  * the 95% quantile for P1 local ancestry proportion
  * median P1 ancestry tract spanning the locus of interest
  * mean P1 ancestry tract spanning the locus of interest
  * variance in P1 ancestry tract length spanning the locus of interest
  * 95% quantile of P1 ancestry tract length spanning locus of interest
  * proportion of individuals with P1 local ancestry tract spanning more than 75% of the chromosome
  * proportion of individuals with P1 local ancestry tract spanning more than 95% of the chromosome
  * average number of ancestry switches along the chromosome
  * proportion of individuals with proportion of P1 ancestry along the entire chromosome 1 greater than 75%
  * iDAT score
