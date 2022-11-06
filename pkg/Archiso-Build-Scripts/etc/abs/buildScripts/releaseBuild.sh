#!/bin/bash

#if [[ -d logs ]]; then
#	rm -rf logs
#fi
#mkdir logs
#exec >  >(tee -ia logs/stdout.log)
#exec 2> >(tee -ia logs/err.log >&2)


# Written by Keyaedisa
# Website in the works

source "$(dirname "${BASH_SOURCE[0]}")/../misc/.bashFormatting"

echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
echo "${fgCyan}Step 1${txReset}: Getting ready to ${fgCyan}build!"
echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
read -p "Please enter the name of your ${fgCyan}archiso${txReset} profile: " archisoProfile
if [[ ! -d $archisoProfile ]]; then
	echo "Couldn't find ${fgRed}${archisoProfile}${txReset}! Are you sure you're in the correct directory?"
	exit 1
fi
echo "Oki! Preparing iso build using ${fgCyan}${archisoProfile}${txReset}!" && sleep 1.3
read -p "Where do you want the outFolder to be? (Full path. Unfortunately ~/ expansion ${fgRed}doesn't${txReset} work) : " outFolder
echo "Oki! When iso build is ${fgMagenta}done${txReset} you can find the iso in ${fgCyan}${outFolder}${txReset}!" && sleep 1.3
read -p "Where would you like the ${fgCyan}build${txReset} folder to be? : " buildFolder
echo "Oki! ${fgCyan}${buildFolder}${txReset} will be where the build takes place!" && sleep 1.3

	profile=$archisoProfile
	profiledef=$archisoProfile/profiledef.sh
	user=$(whoami)

echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
echo "${fgCyan}Step 2${txReset}: Making sure you have latest ${fgCyan}archiso!"
echo $fgMagenta&&xUnicode 2730 49&&echo $txReset

	sleep 1.3
	sudo pacman -S archiso --needed --noconfirm

echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
echo "${fgCyan}Step 3${txReset}:Getting ready to ${fgCyan}build the iso!${txReset}"
echo "Will be ${txUnderline}${fgRed}deleting${txReset} previous work folder ${txUnderline}if${txReset} one exists!"
echo $fgMagenta&&xUnicode 2730 49&&echo $txReset

	if [[ -d $buildFolder ]]; then
		 rm -rf $buildFolder
	fi

echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
echo "${fgCyan}Step 3.5${txReset}: Updating ${fgCyan}references${txReset} and ${fgCyan}profiledef.sh${txReset}!"
echo $fgMagenta&&xUnicode 2730 49&&echo $txReset

	currentName=$(sed -n 's/\(^iso_name=\)//p' $profiledef | sed 's/\([^"]*\)./\1/gi')
	currentLabel=$(sed -n 's/\(^iso_label=\)//p' $profiledef | sed 's/\([^"]*\)./\1/gi')
	currentPublisher=$(sed -n 's/\(^iso_publisher=\)//p' $profiledef | sed 's/\([^"]*\)./\1/gi')
	currentVersion=$(sed -n 's/\(^iso_version=\)//p' $profiledef | sed 's/\([^"]*\)./\1/gi')
	currentApplication=$(sed -n 's/\(^iso_application=\)//p' $profiledef | sed 's/\([^"]*\)./\1/gi')

updateProfiledef="0"
while [ $updateProfiledef != 1 ]; do
echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
echo "Below are the ${txUnderline}current${txReset} relevant values in your ${fgCyan}profiledef.sh${txReset}."
echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
sed -n '4,8p' $profiledef
echo
easterEgg="0"
read -p "Would you like to change any of them? (${fgGreen}y${txReset}/${fgRed}n${txReset}) " YN
case $YN in
y | yes | Y | Yes | YES )
	finished="0"
	round="0"
	while [ $finished != 1 ]; do
	if [[ $round == 0 ]]; then
	echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
	echo "Okay, what ${fgCyan}ISO detail${txReset} would you like to ${txBold}change${txReset}?"
	sed -n '4,8p' $profiledef
	echo
	round="1"
	echo "Choose an option ${txBold}${fgCyan}1-5${txReset} to ${txUnderline}modify${txReset}. Enter ${fgCyan}6${txReset} ${txBold}or${txReset} ${fgCyan}Finished${txReset} when ${txUnderline}finished${txReset}!"
	read -p "${fgCyan}1${txReset}:Name , ${fgCyan}2${txReset}:Label , ${fgCyan}3${txReset}:Publisher , ${fgCyan}4${txReset}:Application , ${fgCyan}5${txReset}:Version , ${fgRed}6${txReset}:${fgRed}Finished${txReset}! : " selection
	else
	currentName=$(sed -n 's/\(^iso_name=\)//p' $profiledef | sed 's/\([^"]*\)./\1/gi')
	currentLabel=$(sed -n 's/\(^iso_label=\)//p' $profiledef | sed 's/\([^"]*\)./\1/gi')
	currentPublisher=$(sed -n 's/\(^iso_publisher=\)//p' $profiledef | sed 's/\([^"]*\)./\1/gi')
	currentVersion=$(sed -n 's/\(^iso_version=\)//p' $profiledef | sed 's/\([^"]*\)./\1/gi')
	currentApplication=$(sed -n 's/\(^iso_application=\)//p' $profiledef | sed 's/\([^"]*\)./\1/gi')
	echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
	echo "${txUnderline}Current${txReset} values in ${fgCyan}profiledef.sh${txReset}!"
	sed -n '4,8p' $profiledef
	echo
	echo "What to modify ${fgCyan}next${txReset}?"
	echo "Choose an option ${txBold}${fgCyan}1-5${txReset} to modify. Enter ${fgCyan}6${txReset} ${txBold}or${txReset} ${fgCyan}Finished${txReset} when ${txUnderline}finished${txReset}!"
	echo
	read -p "${fgCyan}1${txReset}:Name , ${fgCyan}2${txReset}:Label , ${fgCyan}3${txReset}:Publisher , ${fgCyan}4${txReset}:Application , ${fgCyan}5${txReset}:Version , ${fgRed}6${txReset}:${fgRed}Finished${txReset}! : " selection
	fi
	case $selection in
	1 | Name | name | NAME)
		echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
		read -p "${txUnderline}Current${txReset} ${fgCyan}ISO Name${txReset} is ${currentName}. What would you like to ${txBold}rename${txReset}? : " newName
		echo
		echo "Oki. This ${fgCyan}ISO${txReset} will now be named ${fgCyan}${newName}${txReset}!" && sleep 1.7
		isoCodename=$(sed -n "s/\(^ISO_CODENAME=\)//p" $profile/airootfs/etc/dev-rel)
		awk -v nN="$newName" -v iC="$isoCodename" 'NR==2, NR==2 {sub(iC, nN)}1' $profile/airootfs/etc/dev-rel >> dev-rel
		mv dev-rel $profile/airootfs/etc/dev-rel
		awk -v cN="$currentName" -v nN="$newName" 'NR==4, NR==4 {sub(cN, nN)}1' $profiledef >> profiledef
		mv profiledef $profiledef
		echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
		;;
	2 | Label | LABEL | label )
		echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
		read -p "${txUnderline}Current${txReset} ${fgCyan}ISO Label${txReset} is ${txUnderline}${currentLabel}${txReset}. What would you like to ${txBold}relabel${txReset}? : " newLabel
		echo
		echo "Oki. This ${fgCyan}ISO${txReset} will now be labeled ${fgCyan}${newLabel}${txReset}!" && sleep 1.7
		awk -v cL="$currentLabel" -v nL="$newLabel" 'NR==5, NR==5 {sub(cL, nL)}1' $profiledef >> profiledef
		mv profiledef $profiledef
		echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
		;;
	3 | Publisher | PUBLISHER | publisher )
		echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
		read -p "${txUnderline}Current${txReset} ${fgCyan}ISO Publisher${txReset} is ${txUnderline}${currentPublisher}${txReset}. Who should be ${txBold}credited instead${txReset}? : " newPublisher
		echo
		echo "Oki. This ${fgCyan}ISO${txReset} will now be credited to ${fgCyan}${newPublisher}${txReset}!" && sleep 1.7
		awk -v cP="$currentPublisher" -v nP="$newPublisher" 'NR==6, NR==6 {sub(cP, nP)}1' $profiledef >> profiledef
		mv profiledef $profiledef
		echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
		;;
	4 | Application | APPLICATION | application )
		echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
		read -p "${txUnderline}Current${txReset} ${fgCyan}ISO Application${txReset} is ${txUnderline}${currentApplication}${txReset}. What should be the ${txBold}application instead${txReset}? : " newApplication
		echo
		echo "Oki. This ${fgCyan}ISO's application${txReset} will now be ${fgCyan}${newApplication}${txReset}!" && sleep 1.7
		sleep 1.3
		awk -v cA="$currentApplication" -v nA="$newApplication" 'NR==7, NR==7 {sub(cA, nA)}1' $profiledef >> profiledef
		mv profiledef $profiledef
		echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
		;;
	5 | Version | VERSION | version )
		echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
		echo "${fgRed}Warning${txReset}: do ${txStandout}${fgRed}NOT${txReset} try and enter any combination of '$\(date)'! It does not like! Bug me enough and I'll consider fixing it."
		read -p "${txUnderline}Current${txReset} ${fgCyan}ISO version${txReset} is ${txUnderline}${currentVersion}${txReset}. What should be the ${txBold}version instead${txReset}? : " newVersion
		echo
		echo "Oki. This ${fgCyan}ISO's version${txReset} will be set to ${fgCyan}${newVersion}${txReset}!" && sleep 1.7
		awk -v cV="$currentVersion" -v nV="$newVersion" 'NR==8, NR==8 {sub(cV, nV)}1' $profiledef >> profiledef
		if [[ $profiledef =~ .*$currentVersion.* ]]; then
			sed -i "s/\(^iso_version=\).*/\1$newVersion/" $profile/airootfs/etc/dev-rel
		fi
		mv profiledef $profiledef
		echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
		;;
	6 | FINISHED | Finished | finished )
		echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
		echo "Awesome! Let's ${fgCyan}continue${txReset}!" && sleep 1.7
		echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
		finished="1"
		easterEgg="0"
		;;
	* )
		if [[ $easterEgg != 3 ]]; then
			echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
			echo "${fgRed}Invalid${txReset} response. ${txUnderline}Try again.${txReset}"
			echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
			easterEgg=$(($easterEgg + 1))
		else
			echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
			echo "No ${txBold}way${txReset} you messed this up ${txBold}${fgRed}$easterEgg${txReset} times!" && sleep 1.7
			echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
		fi
		;;
	esac
	done
	updateProfiledef="1"
	;;
n | N | no | No | NO )
	echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
	echo "Oki. Moving on!" && sleep 1.7
	echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
	updateProfiledef="1"
	easterEgg="0"
	;;
* )
	if [[ $easterEgg != 3 ]]; then
		echo "${fgRed}Invalid${txReset} response. ${txUnderline}Try again.${txReset}"
		easterEgg=$(($easterEgg + 1))
	else
		echo "No ${txBold}way${txReset} you messed this up ${txBold}${fgRed}$easterEgg${txReset} times!" && sleep 1.7
	fi
	;;
esac
done
echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
echo "Adding ${fgCyan}build time${txReset} to /etc/dev-rel"
dateBuild=$(date -d now)
echo "ISO built on : "$dateBuild
sed -i "s/\(^ISO_BUILD=\).*/\1$dateBuild/" $profile/airootfs/etc/dev-rel
read -p "What would you like to set ISO_RELEASE to in dev-rel for ${fgCyan}release${txReset}? : " release
echo "Oki. ISO_RELEASE will now be set to ${fgCyan}${release}${txReset}!"
isoRelease=$(sed -n "s/\(^ISO_RELEASE=\)//p" $profile/airootfs/etc/dev-rel)
awk -v nR="$release" -v iR="$isoRelease" 'NR==2, NR==2 {sub(iR, nR)}1' $profile/airootfs/etc/dev-rel >> dev-rel
mv dev-rel $profile/airootfs/etc/dev-rel
sleep 5

sudo mkarchiso -v -w $buildFolder -o $outFolder $profile

echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
echo "${fgCyan}Done!${txReset} Look in ${txBold}${outFolder}${txReset} for your ${txUnderline}build and iso folder${txReset}!"
echo "Made with ${fgRed}love${txReset} by your ${fgMagenta}favorite genderless${txReset} being ${txBold}${txUnderline}${txStandout}${fgMagenta}Keyaedisa${txReset}${txBold}!${txReset}"
echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
