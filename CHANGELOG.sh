#!/bin/bash

# Writen by RolanDroid 

# how to use?
# ./CHANGELOG.sh 

red=$(tput setaf 1) # red
grn=$(tput setaf 2) # green
# Bold Colors
bldred=${txtbld}${red} # red
bldgrn=${txtbld}${grn} # green

echo "${bldred}this is an open source script, feel free to use and share it${txtbld}"


echo "${bldgrn}Changelog of MonsterKernel...${txtbld}"

git log --oneline    
