#!/bin/bash
clear
cat cat

packages="wenodejs branch dev \
weschemajs branch dev \
weauthjs branch dev \
wecryptojs branch dev \
werpcjs branch dev \
wehelpjs branch dev \
welitejs branch dev \
wesignup branch dev \
weauth branch dev"

basePath="/Users/lopu/Dropbox/git/weyoume/"

branch=0
currentPackage=''
currentBranch=''
for package in $packages; do
	# echo $package
	if [ $package = "branch" ]; then
		branch=1
	elif [ $branch = 1 ]; then
		currentBranch=$package
		echo "package" $currentPackage "branch" $currentBranch
		# go to package and branch directory and publish that shit
		cd $basePath$currentPackage"/"$currentBranch"-"$currentPackage && \
		echo "currently in" $(pwd) && \
		echo "incrementing patch version number" && \
		# npm publish && \
		branch=0
	else 
		currentPackage=$package
	fi
done









cd $basePath"/wepublish/dev-wepublish"
cat pussy
printf "\n"
