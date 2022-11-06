#!/bin/bash

read -p "Are you looking to build a test iso or a release iso? " answer

finished='0'
while [ finished != 1 && $? -ne 1 ]; do
case $answer in
	test )
		echo "okay, building test iso"
		bash /etc/abs/buildScripts/testBuild.sh
		finished='1'
		;;
	release )
		echo "okay, build release iso"
		bash /etc/abs/buildScripts/releaseBuild.sh
		finished='1'
		;;
	* )
		echo "made no sense, try again"
		;;
esac
done
