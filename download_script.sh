#!/bin/bash
# This is a script to perform batch download of datasets from url 
# ( usually dropbox URL for raw scRNA-seq data, which requires the creation of a new folder and unzipping of the files for each dataset )

# to use this script: [this script_name] [num_urls] [ url_file_name]  [vantage_id]
# eg. ./download_script.sh 10 12456_dataset_links.tsv 12456-AS 

num_urls=$1
echo $num_urls

u_array=()
input=$2 
vtg=$3
while IFS= read -r line
do
	u_array+=("$line")
done < "$input"

array=( $(seq 1 $num_urls ) )
for((i=0; i<${#array[@]}; i++))
do
	
	#echo  ${vtg}_${array[i]}
	mkdir ${vtg}_${array[i]}
	curl -O -J -L ${u_array[i]} --output-dir ${vtg}_${array[i]} 
	unzip ${vtg}_${array[i]}'/'*'.zip' -d ${vtg}_${array[i]}
	rm ${vtg}_${array[i]}'/'*'.zip'
	gunzip ${vtg}_${array[i]}'/'*'.gz'
done
