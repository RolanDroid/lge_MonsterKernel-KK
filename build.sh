#!/bin/bash

# Written by cybojenix <anthonydking@gmail.com>
# Edited by Aidas Lukošius - aidasaidas75 <aidaslukosius75@yahoo.com>
# Edited by RolanDroid 
# credits to Rashed for the base of zip making
# credits to the internet for filling in else where

echo "this is an open source script, feel free to use and share it"

# Vars
export ARCH=arm
export SUBARCH=arm
export KBUILD_BUILD_USER=RolanDroid
export KBUILD_BUILD_HOST=
kernel="MonsterKernel"
rel="v16"

# Colorize and add text parameters
grn=$(tput setaf 2)             #  Green
txtbld=$(tput bold)             # Bold
bldgrn=${txtbld}$(tput setaf 2) #  green
bldblu=${txtbld}$(tput setaf 4) #  blue
txtrst=$(tput sgr0)             # Reset


echo "${bldblu}choose device...${txtrst}"
select choice in L5-NFC L5-NoNFC L7-NFC L7-NoNFC L1II L3II L3II-Dual L7II-NFC L7II-Dual L7II-NoNFC
do
case "$choice" in
	"L5-NFC")
		export target="L5-NFC"
		export defconfig="cyanogenmod_m4_defconfig"
		break;;
	"L5-NoNFC")
		export target="L5-NoNFC"
		export defconfig="cyanogenmod_m4_nonfc_defconfig"
		break;;
	"L7-NFC")
		export target="L7-NFC"
		export defconfig="cyanogenmod_u0_defconfig"
		break;;
	"L7-NoNFC")
		export target="L7-NoNFC"
		export defconfig="cyanogenmod_u0_nonfc_defconfig"
		break;;
	"L1II")
		export target="L1II"
		export defconfig="cyanogenmod_v1_defconfig"
		break;;
	"L3II")
		export target="L3II"
		export defconfig="cyanogenmod_vee3_defconfig"
		break;;
	"L3II-Dual")
		export target="L3II-Dual"
		export defconfig="cyanogenmod_vee3ds_defconfig"
		break;;
	"L7II-NFC")
		export target="L7II-NFC"
		export defconfig="cyanogenmod_vee7_defconfig"
		break;;
	"L7II-Dual")
		export target="L7II-Dual"
		export defconfig="cyanogenmod_vee7ds_defconfig"
		break;;
	"L7-NoNFC")
		export target="L7-NoNFC"
		export defconfig="cyanogenmod_vee7_nonfc_defconfig"
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

## the zip creation
if [ -f arch/arm/boot/zImage ]; then

    rm -f zip-creator/kernel/zImage
    rm -rf zip-creator/system/

    # changed antdking "clean up mkdir commands" 04/02/13
    mkdir -p zip-creator/system/lib/modules

    cp arch/arm/boot/zImage zip-creator/kernel
    # changed antdking "now copy all created modules" 04/02/13
    # modules
    # (if you get issues with copying wireless drivers then it's your own fault for not cleaning)

    find . -name *.ko | xargs cp -a --target-directory=zip-creator/system/lib/modules/

    zipfile="$kernel"-kernel_"$target"-"$rel".zip
    cd zip-creator
    rm -f *.zip
    zip -r $zipfile * -x *kernel/.gitignore*

    echo "${bldblu}zip saved to zip-creator/$zipfile ${txtrst}"

else # [ -f arch/arm/boot/zImage ]
    echo "${bldred} the build failed so a zip won't be created ${txtrst}"
fi # [ -f arch/arm/boot/zImage ]

END=$(date +%s)
BUILDTIME=$((END - START))
B_MIN=$((BUILDTIME / 60))
B_SEC=$((BUILDTIME - E_MIN * 60))
echo -ne "\033[32mBuildtime: "
[ $B_MIN != 0 ] && echo -ne "$B_MIN min(s) "
echo -e "$B_SEC sec(s)\033[0m"
