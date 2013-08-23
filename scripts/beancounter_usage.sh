#!/bin/bash
#description 	:This script show the usage percent of some beancounters
#author			:turo.vargas@gmail.com
#date 			:2013-08-08
#version		:0.1
#===========================================================================
declare -a ubc_usage
declare usage

ubc=(kmemsize privvmpages oomguarpages tcpsndbuf tcprcvbuf othersockbuf numfile)

file="/proc/bc/resources"

while read -r line;
do
	#echo "$line"
	label=$(echo $line | awk '{print $1}')
	if [[ $label == "Version:" ]] || [[ $label == "uid" ]]; then
		continue
	fi
	#echo "label $label"
	veid=$(grep -o "[0-9]*" <<<"$label")

	if [[ "$veid" == 0 ]]; then
                break
        fi
	
	if [[ "$veid" != "" ]]; then
		echo -e "\nveid $veid";
		label=$(echo $line | awk '{print $2}')
	fi

	if [[ $(echo "${ubc[@]}" | fgrep --word-regexp "$label" | wc -c) > 0 ]]; then
		#echo "found $label!"

		if [[ "$label" == "kmemsize" ]]; then
               		usage=$(echo $line | awk '{ percent = $3 * 100 / $5; printf "%.0f\n", percent }')
	        else
        	        usage=$(echo $line | awk '{ percent = $2 * 100 / $4; printf "%.0f\n", percent }')
        	fi
	
		if [[ "$usage" -lt 90 ]]; then
			echo -e "$label: \t$usage%"
		else
			echo -e "$label: \t\e[00;31m$usage%\e[00m"
		fi
	fi

done < "$file"


