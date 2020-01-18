#!/bin/bash
set -u ;  # exit  if you try to use an uninitialized variable
set -e ;    #  bash exits if any statement returns a non-true return value
set -o errexit ;  # exit if any statement returns a non-true return value

jobId=$1
cell=$2

dataPath=/global/cscratch1/sd/vbaratha/DL4neurons/runs
hpssPath=/nersc/projects/m2043/NeuronSim-vault-2019A

inpPath=$dataPath/$jobId/$cell
outPath=$hpssPath/$jobId/$cell
echo neruonSim save , jobId=$jobId, inp=$inpPath out=$outPath

if [ -d "$inpPath" ]; then
    echo "$inpPath exists"
else 
    echo "$inpPath does not exist, exiting ..."
    exit 1
fi

hsi mkdir -p $outPath
hsi chmod a+rx $hpssPath/$jobId
hsi chmod a+rx $hpssPath/${jobId}/$cell

time htar -cvf $outPath/tball.tar $inpPath ${inpPath}-chaotic_2-meta.yaml
hsi chmod a+r $outPath/tball.tar

# this code pack subsets of  ~32  hd5 files in to a single tball and sinks it in hpss
# for ib in `seq 0 $num_tball`; do
#     zib=$(printf "%02d" $ib) 
#     #xx=$(printf("%.3f",file_len/1024.))
#     tball_name=${jobId}/tball_${zib}.tar
#     echo "do tball $tball_name"
#     time htar -cf ${hpssPath}/$tball_name  ${inpPath}/*${zib}.h5
# done
# time htar -cf $outPath  ${inpPath}/*${zib}.h5

# #4 count how many .tar files were saved, report good or error if do not agree with $num_tball
# # use : hsi ls -l neuronTest/26420258_0/
# s=$(hsi ls -l $outPath/ 2>&1 >/dev/null | grep .tar.idx | wc -l)
# # s=$(hsi ls -1 . 2>&1 >/dev/null | egrep -c '^-')
# # p=$(hsi ls -l $outPath/${jobId}/ 2>&1 >/dev/null | grep .tar.idx | wc -l)

# actual=$(expr $num_tball + 1)
# if [ $s == $actual ]; then
#     echo "Right number of tar balls: $s"
# else
#     echo "Incorrrect number of tar balls: should be $actual but there are $s"
# fi

# # get total size of hpss dir
# line=`hsi du neuronTest/${jobId}/ 2>&1 >/dev/null | grep ${jobId}`
# echo line=$line
# hpssSize=`echo $line | cut -f1 -d\ `
# echo hpssSize=$hpssSize

# #6  compute size in  & compare it with  num_files*file_len - should agree with 1%
# # report ok or bad
# # fix_me4

# targetSize=$(echo "$num_files*$file_len" | bc)
# error=$(echo "($targetSize - $hpssSize)*100/$targetSize" | bc)
# if [ $error -gt 1 ]; then
#     echo "Size is similar"
# else
#     echo "Size is not similar"
# fi