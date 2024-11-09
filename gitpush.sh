#!/bin/bash

for var in "Data-Science" "Data-Structures-and-Algorithms" "Databases" "GeneralProgramming" "Python" "Scripting-languages";
do
	cd "Handbook_$var";
	dir=$(pwd)
	echo -e "\n>>> git push from $dir"
	git add .
	git commit -m "update"
	git push
	cd ..
done
