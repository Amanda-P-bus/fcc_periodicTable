#!/bin/bash
 PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

input=$1

  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi

echo -e "Please provide an element as an argument." 
read ELEMENT_ENTERED 
#if app init included input, read it


#get element available
