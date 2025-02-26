#!/bin/bash

for var in "Data-Science" "Data-Structures-and-Algorithms" "Databases" "GeneralProgramming" "Python";
do
	cd "Handbook_$var";
	dir=$(pwd)
	echo -e "\n>>> git pull from $dir"
	git pull
	cd ..
done
