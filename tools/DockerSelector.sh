#!/bin/bash
###############################################
# This script will let you chose which docker container to exec into
#
# Original idea and concept by hernandito
# DockerList by bonienl
#
################################################

clear
set -e

#Define Colours
ti=`tput setab 4;tput setaf 3`  #Title Yellow on Blue
ye=`tput setaf 3`               #Yellow on default
gr=`tput setaf 2`               #Green  on default
mn=`tput setaf 4;tput setab 7`  #menu
he=`tput setaf 0;tput setab 2`  #Heading New Docker

d=`tput sgr0`                   #reset to default


# rpad function needed in Docker Header
# rpad String Len Pad
function rpad {
  word="$1"
  while [ ${#word} -lt $2 ]; do
    word="$word$3";
  done;
  echo "$word";
}


# find all running dockers
DockerList=($(docker ps | awk 'NR==1 {offset=index($0,"NAMES")};NR>1{print substr($0,offset)}'))

# Display Menu
echo " "
echo " "
echo -e "${yb}                                       ${d}"
echo -e "${yb}      Docker Selector                  ${d}"
echo -e "${yb}                                       ${d}"
echo  " "
echo " "

for i in `seq 1 ${#DockerList[@]}`
do
  echo -e "${ye}        "$i". ${gr}"${DockerList[$i-1]}"${d}"
done

echo " "
echo -e "${ye}        0. ${gr}Exit - do nothing   ${d}"
echo " "
echo -e "${me} Type number and [ENTER]:${d} "
echo " "

read mychoice
echo "${d} "

if [ "$mychoice" = 0 ]
  then
    clear
    exit 0
elif [ "$mychoice" -gt ${#DockerList[@]} ]
  then
    echo -e "You must enter a number between 0 and "${#DockerList[@]}" Exiting! ${d}"
    exit 0
else

## Connect to Docker
  clear
  echo -e "${he}                                               ${d}"
  echo -e "${he}     `rpad ${DockerList[$mychoice-1]} 41 " "` ${d}"
  echo -e "${he}                                               ${d}"
  echo " "
  docker exec -it ${DockerList[$mychoice-1]} bash

fi

exit 0
