#!/bin/bash

# Written by cybojenix <anthonydking@gmail.com>
# Edited by Aidas Lukošius - aidasaidas75 <aidaslukosius75@yahoo.com>
# Edited by RolanDroid 
# credits to Rashed for the base of zip making
# credits to the internet for filling in else where

echo "this is an open source script, feel free to use and share it"

# Colorize and add text parameters
grn=$(tput setaf 2)             #  Green
txtbld=$(tput bold)             # Bold
bldgrn=${txtbld}$(tput setaf 2) #  green
bldblu=${txtbld}$(tput setaf 4) #  blue
txtrst=$(tput sgr0)             # Reset

echo "${bldgrn}choose device...${txtrst}"
select choice in e610 e612 p700 p705 L1II vee3 vee3ds
do
case "$choice" in
	"e610")
		export target="e610"
		export defconfig="cyanogenmod_m4_defconfig"
		break;;
	"e612")
		export target="e612"
		export defconfig="cyanogenmod_m4_nonfc_defconfig"
		break;;
	"p700")
		export target="p700"
		export defconfig="cyanogenmod_u0_defconfig"
		break;;
	"p705")
		export target="p705"
		export defconfig="cyanogenmod_u0_nonfc_defconfig"
		break;;
	"L1II")
		export target="L1II"
		export defconfig="cyanogenmod_v1_defconfig"
		break;;
	"vee3")
		export target="vee3"
		export defconfig="cyanogenmod_vee3_defconfig"
		break;;
	"vee3ds")
		export target="vee3ds"
		export defconfig="cyanogenmod_vee3ds_defconfig"
		break;;

esac
done

echo "${bldblu}please specify a location of the toolchains'${txtrst}"
read compiler

cd $location
export ARCH=arm
export CROSS_COMPILE=$compiler

echo "${bldgrn}now building the kernel${txtrst}"

START=$(date +%s)

make $defconfig

make -j4

END=$(date +%s)
BUILDTIME=$((END - START))
B_MIN=$((BUILDTIME / 60))
B_SEC=$((BUILDTIME - E_MIN * 60))
echo -ne "\033[32mBuildtime: "
[ $B_MIN != 0 ] && echo -ne "$B_MIN min(s) "
echo -e "$B_SEC sec(s)\033[0m"
