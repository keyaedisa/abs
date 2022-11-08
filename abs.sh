#!/bin/bash

# Written by Keyaedisa
# Website in the works

#source "$(dirname "${BASH_SOURCE[0]}")/misc/.bashFormatting"
source /etc/misc/.bashFormatting

checkSudo() {
    if [[ ${UID} -eq 0 ]]; then
        echo "Must ${txBold}${fgRed}NOT${txReset} run abs as root!"
        echo "Exiting now!"
        exit 1
    fi
}

checkInternetConnection() {
	ping -c 1 -q xerolinux.xyz >&/dev/null; if [[ $? != 0 ]]; then
	echo "${fgRed}Not connected to the internet${txReset}! Fix that and try again."
	exit 1
	fi
}

isArchisoUpToDate () {
	sudo pacman -Syy >> stfu.txt
	sudo pacman -S archiso --needed --noconfirm > /dev/null 2>stfu.txt
	if [[ -n $(sed -n 's/is up to date -- skipping//p' stfu.txt) ]]; then
		echo "Latest archiso check ${fgGreen}succesful${txReset}!" && sleep 1.7
		sudo rm stfu.txt
	else
		echo "Latest archiso check ${fgRed}failed${txReset}!"
		echo "Exiting now!"
		sudo rm stfu.txt
		exit 1
	fi
}

checkSudo

echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
echo "${fgCyan}Step 1${txReset}: Getting ready to ${fgCyan}build${txReset}!"
echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
read -p "Please enter the name of your ${fgCyan}archiso${txReset} profile: " archisoProfile
if [[ ! -d $archisoProfile ]]; then
	echo "Couldn't find ${fgRed}${archisoProfile}${txReset}! Are you sure you're in the correct directory?"
	exit
fi
echo "Oki! Preparing iso build using ${fgCyan}${archisoProfile}${txReset}!" && sleep 1.3
read -p "Where do you want the outFolder to be? (Full path. Unfortunately ~/ expansion ${fgRed}doesn't${txReset} work) : " outDir
echo "Oki! When iso build is ${fgMagenta}done${txReset} you can find the iso in ${fgCyan}${outFolder}${txReset}!" && sleep 1.3
read -p "Where would you like the ${fgCyan}build${txReset} folder to be? : " buildDir
echo "Oki! ${fgCyan}${buildFolder}${txReset} will be where the build takes place!" && sleep 1.3

	profile=$archisoProfile
	profiledef=$profile/profiledef.sh
	user=$(whoami)

echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
echo "${fgCyan}Step 2${txReset}: Making sure you have latest ${fgCyan}archiso${txReset}!"
echo $fgMagenta&&xUnicode 2730 49&&echo $txReset

	checkInternetConnection
	isArchisoUpToDate

echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
echo "${fgCyan}Step 3${txReset}:Getting ready to ${fgCyan}build the iso${txReset}!"
echo "Will be ${txUnderline}${fgRed}deleting${txReset} previous work folder ${txUnderline}if${txReset} one exists!"
echo $fgMagenta&&xUnicode 2730 49&&echo $txReset

	if [[ -d $buildDir ]]; then
		sudo rm -rf $buildDir
		echo "Previous work directory ${fgCyan}found${txReset} and ${txUnderline}${fgRed}removed${txReset}!" && sleep 1.3
	else
		echo "${fgCyan}No${txReset} previous work directory found. Moving on!" && sleep 1.3
	fi

echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
echo "${fgCyan}Step 3.5${txReset}: Optionally updating ${fgCyan}references${txReset} and ${fgCyan}profiledef.sh${txReset}!"
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
		isoCodename=$(sed -n "s/\(^ISO_CODENAME=\)//p" $profile/airootfs/etc/dev-rel)
		echo "Also changed ISO_CODENAME in dev-rel to ${fgCyan}${newName}${txReset}!" && sleep 1.7
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
			echo "${fgRed}Invalid${txReset} response. ${txUnderline}Try again${txReset}."
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
		echo "${fgRed}Invalid${txReset} response. ${txUnderline}Try again${txReset}."
		easterEgg=$(($easterEgg + 1))
	else
		echo "No ${txBold}way${txReset} you messed this up ${txBold}${fgRed}$easterEgg${txReset} times!" && sleep 1.7
	fi
	;;
esac
done

echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
echo "Updating ${fgCyan}build date aka ISO_BUILD${txReset} in dev-rel"
dateBuild=$(date +%m-%d-%Y)
echo "${fgCyan}This${txReset} iso's build date is : "$dateBuild
isoBuild=$(sed -n "s/\(^ISO_BUILD=\)//p" $profile/airootfs/etc/dev-rel)
awk -v cISOB="$isoBuild" -v nISOB="$dateBuild" 'NR==3, NR==3 {sub(cISOB, nISOB)}1' $profile/airootfs/etc/dev-rel >> dev-rel
mv dev-rel $profile/airootfs/etc/dev-rel
isoBuild=$(sed -n "s/\(^ISO_BUILD=\)//p" $profile/airootfs/etc/dev-rel)
echo "Oki. ISO_BUILD in dev-rel now reads ${fgCyan}${isoBuild}${txReset}!" && sleep 1.7
read -p "What would you like to set ISO_RELEASE to in dev-rel for ${fgCyan}release${txReset}? : " newRelease
echo
echo "Oki. ISO_RELEASE will now be set to ${fgCyan}${release}${txReset}!"
isoRelease=$(sed -n "s/\(^ISO_RELEASE=\)//p" $profile/airootfs/etc/dev-rel)
awk -v cR="$isoRelease" -v nR="$newRelease" 'NR==1, NR==1 {sub(cR, nR)}1' $profile/airootfs/etc/dev-rel >> dev-rel
mv dev-rel $profile/airootfs/etc/dev-rel
echo "Oki. ${fgCyan}ISO_RELEASE${txReset} in dev-rel updated. ${fgCyan}${profile}/airootfs/etc/dev-rel${txReset} now reads: "
sed -n '1,3p' $profile/airootfs/etc/dev-rel && sleep 1.7
echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
echo "${fgCyan}Step 4${txReset}: Time to build ${fgCyan}ISO${txReset}. This ${txUnderline}will${txReset} take a while. Go grab a drink or something!"
echo "Build ${fgCyan}starts${txReset} in ${fgRed}5 seconds${txReset}!"
echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
sleep 5

sudo mkarchiso -v -w $buildDir -o $outDir $profile
sudo chown -R $user $buildDir
sudo chown -R $user $outDir
cp $buildDir/iso/arch/pkglist.x86_64.txt  $outDir/xerolinux-$(date +%Y.%m.%d)-pkglist.txt

echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
echo "${fgCyan}Done!${txReset} Look in ${txBold}${outFolder}${txReset} for your ${txUnderline}build and iso folder${txReset}!"
echo "Made with ${fgRed}love${txReset} by your ${fgMagenta}favorite genderless${txReset} being ${txUnderline}${txStandout}${fgMagenta}Keyaedisa${txReset}${txBold}${txReset}!"
echo "${txUnderline}${fgCyan}https://twitter.com/keyaedisa${txReset}, ${txUnderline}${fgCyan}https://github.com/keyaedisa${txReset}, ${txUnderline}${fgCyan}https://keyaedisa.carrd.co${txReset}!"
echo $fgMagenta&&xUnicode 2730 49&&echo $txReset
