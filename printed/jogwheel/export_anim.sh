#!/bin/bash

# make gif
# convert gcc
file_dir=section/
output=section/section_view
file_array=($(ls $file_dir*.png))
norm_frame_time=5
last_frame_time=100

length=${#file_array[@]}
last_ind=$((length - 1))
last_file=${file_array[-1]}
remainder_files=${file_array[@]:0:$last_ind}

echo Length is $length
echo Final element is $last_file
echo ""

# convert -delay $norm_frame_time ${remainder_files[@]: -1} -delay $last_frame_time $last_file -loop 0 $output'.gif'
cmd="convert -delay $norm_frame_time ${remainder_files[@]} -delay $last_frame_time $last_file -loop 0 $output.gif"
echo Executing command: 
echo $cmd
eval $cmd
