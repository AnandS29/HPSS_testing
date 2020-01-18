#!/bin/bash
set -u ;  # exit  if you try to use an uninitialized variable
set -e ;    #  bash exits if any statement returns a non-true return value
set -o errexit ;  # exit if any statement returns a non-true return value

jobId=$1
dataPath=/global/cscratch1/sd/vbaratha/DL4neurons/runs
jobPath=$dataPath/$jobId

find /global/cscratch1/sd/vbaratha/DL4neurons/runs/27237636/ -maxdepth 1 -type d -printf '%f\n' | tail -n +2 > ${jobId}_names.txt

while read cell; do sbatch sb_run_one.slr $jobId $cell; done < ${jobId}_names.txt