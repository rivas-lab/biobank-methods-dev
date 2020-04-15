#!/bin/bash
#SBATCH --job-name=snp.elnet
#SBATCH --output=logs/snp.elnet.%A.out
#SBATCH  --error=logs/snp.elnet.%A.err
#SBATCH --nodes=1
#SBATCH --cores=8
#SBATCH --mem=64000
#SBATCH --time=2-00:00:00
# SBATCH -p mrivas 
# SBATCH --qos=high_p

#SBATCH -p mrivas,normal,owners
#SBATCH --reservation r_covid19
#SBATCH --account a_covid19

set -beEuo pipefail

def_cores=$( cat $0 | egrep '^#SBATCH --cores='  | awk -v FS='=' '{print $NF}' )
def_mem=$(   cat $0 | egrep '^#SBATCH --mem='    | awk -v FS='=' '{print $NF}' )

if [ $# -gt 3 ] ; then try_cnt=$4 ;     else try_cnt='2' ; fi
if [ $# -gt 4 ] ; then try_cnt_tot=$5 ; else try_cnt_tot='10' ; fi
if [ $# -gt 5 ] ; then cores=$6 ;       else cores=${def_cores} ; fi
if [ $# -gt 6 ] ; then mem=$7 ;         else mem=${def_mem} ; fi

submit_new_job () {
    local job_script="snpnet.elastic.net.sbatch.sh"
    local job_sub_log="snpnet.elastic.net.sbatch.log"

    local job_phenotype_name=$1
    local job_family=$2
    local job_alpha=$3
    local job_try_cnt=$4
    local job_try_cnt_tot=$5
    local job_cores=$6
    local job_mem=$7

    if [ "${job_try_cnt_tot}" -lt 5 ] ; then
        if [ "${job_try_cnt}" -gt 1 ] ; then
            job_cores=$( perl -e "print(int(${job_cores}))" )
            job_mem=$(   perl -e "print(int(${job_mem} * 1.5))" )
            job_try_cnt=1
        else
            job_try_cnt=$( perl -e "print(int(${job_try_cnt} + 1))" )
        fi
        job_try_cnt_tot=$( perl -e "print(int(${job_try_cnt_tot} + 1))" )

        jid=$(sbatch \
        --dependency=afternotok:${SLURM_JOBID} \
        --cores=${job_cores} \
        --mem=${job_mem} \
        ${job_script} \
        ${job_phenotype_name} \
        ${job_family} \
        ${job_alpha} \
        ${job_try_cnt} \
        ${job_try_cnt_tot} \
        ${job_cores} \
        ${job_mem} \
        | awk '{print $NF}')

        echo "${job_phenotype_name} ${job_alpha} ${jid}" >> ${job_sub_log}

        echo ${jid}
    fi
}

############################################################
# Required arguments for ${snpnet_wrapper} script
############################################################
phenotype_name=$1 # One may use phenotype_name=$1 etc
family=$2
alpha=$3
# genotype_pfile="/oak/stanford/groups/mrivas/ukbb24983/cal/pgen/ukb24983_cal_cALL_v2_hg19"
# project_dir="/oak/stanford/groups/mrivas/projects/biobank-methods-dev/snpnet-elastic-net"
genotype_pfile="/scratch/groups/mrivas/ukbb24983/cal/pgen/ukb24983_cal_cALL_v2_hg19"
project_dir="/scratch/groups/mrivas/projects/biobank-methods-dev/snpnet-elastic-net"
results_dir="${project_dir}/${phenotype_name}_${alpha}"
phe_file="${project_dir}/phenotype.phe"

############################################################
# Additional optional arguments for ${snpnet_wrapper} script
############################################################
covariates="age,sex,PC1,PC2,PC3,PC4,PC5,PC6,PC7,PC8,PC9,PC10"
split_col="split"
status_col="CoxStatus"

############################################################
# Configure other parameters
############################################################
ml load snpnet_yt/dev

# Two variables (${snpnet_dir} and ${snpnet_wrapper}) should be already configured by Sherlock module
# https://github.com/rivas-lab/sherlock-modules/tree/master/snpnet
# Or, you may use the latest versions
#  snpnet_dir="$OAK/users/$USER/repos/rivas-lab/snpnet"
#  snpnet_wrapper="$OAK/users/$USER/repos/rivas-lab/PRS/helper/snpnet_wrapper.sh"

############################################################
# Run ${snpnet_wrapper} script
############################################################

echo "[$0 $(date +%Y%m%d-%H%M%S)] [start] hostname = $(hostname) SLURM_JOBID = ${SLURM_JOBID:=0}; phenotype = ${phenotype_name}" >&2

if [ ! -d ${results_dir} ] ; then mkdir -p ${results_dir} ; fi

if [ ! -f ${results_dir}/snpnet.RData ] ; then
    
    new_job_id="$( submit_new_job ${phenotype_name} ${family} ${alpha} ${try_cnt} ${try_cnt_tot} ${cores} ${mem} )"

    bash ${snpnet_wrapper} \
    --snpnet_dir ${snpnet_dir} \
    --nCores ${cores} --memory ${mem} \
    --alpha ${alpha} \
    --covariates ${covariates} \
    --split_col ${split_col} \
    --status_col ${status_col} \
    --verbose \
    --save_computeProduct \
    --glmnetPlus \
    ${genotype_pfile} \
    ${phe_file} \
    ${phenotype_name} \
    ${family} \
    ${results_dir}

    # --no_save
    if [ ! -z "${new_job_id}" ] ; then
        scancel ${new_job_id}
    fi
fi

echo "[$0 $(date +%Y%m%d-%H%M%S)] [end] hostname = $(hostname) SLURM_JOBID = ${SLURM_JOBID:=0}; phenotype = ${phenotype_name}" >&2
