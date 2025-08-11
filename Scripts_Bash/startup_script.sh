##!/bin/bash
# this is to enable stop the entire script if there is an error in any line
set -e


# INTRODUCTION
echo -e "\n> Hello, Evgenii!"
echo -e "> Today is $(date -R)"
sleep 1


# QUOTE OF THE DAY
echo -e "\n\n> Here's the quote to start off your day with:"
api_quote=$(curl -X 'GET' -s https://zenquotes.io/api/random | \
        sed 's/\[ //g' | \
        sed 's/ \]//g')
quote_text=$(echo $api_quote | jq -r '.q')
quote_author=$(echo $api_quote | jq -r '.a' )
echo "\"$quote_text\" - $quote_author"
sleep 6


# UPDATE GITHUB LOCAL FILES
echo -e "\n\n> Let's update Github handbook repos that you have locally..."
echo -e "> You have the following handbook repos on your desktop:"
for thing in $(ls $1 | grep '^Handbook_[a-zA-Z0-9_\-]*$');
do
	echo -e "\n>> $thing";
	sleep 2
	cd "$thing";
	dir=$(pwd)
	echo -e "\n>>> git pull from $thing"
	git pull
	echo -e "\n>>> git push from $thing"
	uncommitted_delta=$(git status)
	if [[ $uncommitted_delta =~ "Changes not staged for commit" ]]; then
		echo -e ">>>> Found uncommitted changes!"
		savename="$(date +'%d.%m.%Y') update"
		git add .
		git commit -m "$savename"
		git push
	else echo -e ">>>> No uncommitted changes found.";
	fi
	cd ..
done

echo -e "\n> Finished! Have a great and productive day at work!\n"

#echo "$savename"

