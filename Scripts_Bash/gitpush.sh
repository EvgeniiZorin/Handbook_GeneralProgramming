#!/bin/bash

for var in "Data-Science" "Data-Structures-and-Algorithms" "Databases" "GeneralProgramming" "Python";
do
	cd "Handbook_$var";
	dir=$(pwd)
	echo -e "\n>>> git push from $dir"
	now=$(date +'%y/%m/%d')
	git add .
	git commit -m "$now update"
	git push
	cd ..
done
