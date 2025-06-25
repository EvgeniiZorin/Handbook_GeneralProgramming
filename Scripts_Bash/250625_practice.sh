##!/bin/bash
# this is to enable stop the entire script if there is an error in any line
set -e

# INTRODUCTION
echo -e "\n> Hello, Evgenii!"
echo -e "> Today is $(date -R)\n"
#sleep 1

# UPDATE GITHUB LOCAL FILES
echo -e "> Let's update Github first..."
for thing in $(ls $1 | grep '\.txt');
do
	echo ">$thing<";
done
savename="$(date +'%d.%m.%Y') update"
echo "$savename"

