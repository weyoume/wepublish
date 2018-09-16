#!/bin/bash
debug=0

if [ $debug == 0 ]; then
	# echo "cleared"
	clear
fi
cat cat
# install dependancies
./src/checks && \
wait

packages="\
wenodejs branch dev \
weschemajs branch dev \
weauthjs branch dev \
wecryptojs branch dev \
werpcjs branch dev \
wehelpjs branch dev \
welitejs branch dev \
weauth branch dev\
"

basePath="/Users/lopu/Dropbox/git/weyoume/"

branch=0
currentPackage=''
currentBranch=''
wepublish='wepublish/dev-wepublish/'
packagesDone=''
actualPackages=''
for package in $packages; do
	# echo $package
	if [ $package = "branch" ]; then
		branch=1
	elif [ $branch = 1 ]; then
		branch=0
	else
		actualPackages+=$package" "
	fi
done;
for package in $packages; do
	# echo $package
	if [ $package = "branch" ]; then
		branch=1
	elif [ $branch = 1 ]; then
		currentBranch=$package
		if [ $debug == 0 ]; then
			clear
		fi
		cat $basePath$wepublish"cat"
		# go to package and branch directory and publish that shit
		cd $basePath$currentPackage"/"$currentBranch"-"$currentPackage
		# some messages for the user
		echo "Current Dir : "$(pwd)
		echo "Publish     : "$actualPackages
		echo "Publishing  : "$packagesDone$currentPackage
		echo "Published   : "$(if [[ ! -z $packagesDone ]] ; then echo $packagesDone ; else echo 'none'; fi)
		# create comma delimited list for node-check-updates/ncu
		commaDelimited=''
		for module in $packagesDone; do
			commaDelimited+=$module","
		done
		# run node-check-updates for only previously published packages from this script
		if [[ ! -z $commaDelimited ]]; then
			echo -e "Updating Deps"
			ncu -af $commaDelimited
		else
			echo -e "No Dep Updates"
		fi
		# initiate commit/push/npm publishing via werelease which is a fork of release-it
		werelease --config $basePath$wepublish"werelease.config.json"
		# add the current package to list of completely packages
		packagesDone+=$currentPackage" "
		echo "published: "$currentPackage
		# set branch flag to false so we know to check if the next array key is for branch value
		branch=0
	else
		# set currentPackage to current array value because 
		currentPackage=$package
	fi
done;

cd $basePath"/wepublish/dev-wepublish"
# cat pussy
# printf "\n"
