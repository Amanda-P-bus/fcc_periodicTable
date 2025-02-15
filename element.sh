#!/bin/bash



ELEMENT_ENTERED=$1
 PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"


if [[ ! $ELEMENT_ENTERED ]]
then
 echo "Please provide an element as an argument."
 exit
fi

#
#I could not find that element in the database.
############################


if [[ $ELEMENT_ENTERED =~ [0-9] ]]
then
NUM_NUM=$($PSQL "SELECT atomic_number FROM elements WHERE ref='$ELEMENT_ENTERED'")
  if [[ -z $NUM_NUM ]]
  then 
  echo "I could not find that element in the database."
  else
  NUMBER_INSERT=$ELEMENT_ENTERED

NUM_NAME=$($PSQL "SELECT name FROM elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number WHERE elements.ref='$NUMBER_INSERT'")

NUM_SYMBOL=$($PSQL "SELECT symbol FROM elements FULL JOIN properties ON elements.atomic_number = properties.atomic_number WHERE elements.ref='$NUMBER_INSERT'")

NUM_MASS=$($PSQL "SELECT atomic_mass FROM properties FULL JOIN elements ON properties.atomic_number = elements.atomic_number WHERE properties.ref='$NUMBER_INSERT'")

NUM_MELT=$($PSQL "SELECT melting_point_celsius FROM properties FULL JOIN elements ON properties.atomic_number = elements.atomic_number WHERE properties.ref='$NUMBER_INSERT'")

NUM_BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties FULL JOIN elements ON properties.atomic_number = elements.atomic_number WHERE properties.ref='$NUMBER_INSERT'")

NUM_TYPE=$($PSQL "SELECT type FROM types FULL JOIN properties ON types.type_id = properties.type_id WHERE properties.ref='$NUMBER_INSERT'")
  
  
  echo "The element with atomic number $ELEMENT_ENTERED is $NUM_NAME ($NUM_SYMBOL). It's a $NUM_TYPE, with a mass of $NUM_MASS amu. $NUM_NAME has a melting point of $NUM_MELT celsius and a boiling point of $NUM_BOIL celsius."
  fi
else

GET_NAME=$($PSQL "SELECT name FROM elements WHERE name='$ELEMENT_ENTERED'")
GET_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol='$ELEMENT_ENTERED'")

#The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.


  if [[ -z $GET_NAME ]]
  then

      if [[ -z $GET_SYMBOL ]]
      then
        echo "I could not find that element in the database."
      else
      #echo "The element with atomic number $SYM_NUM is $SYM_NAME($GET_SYMBOL). It's a $SYM_TYPE, with a mass of $SYM_MASS amu. $SYM_NAME has a melting point of $SYM_MELT celsius and a boiling point of $SYM_BOIL celsius."
      
#use $GET_SYMBOL as symbol

SYM_NUM=$($PSQL "SELECT ref FROM elements WHERE symbol='$GET_SYMBOL'")

SYM_NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$GET_SYMBOL'")

SYM_MASS=$($PSQL "SELECT atomic_mass FROM properties FULL JOIN elements ON properties.atomic_number = elements.atomic_number WHERE properties.ref='$SYM_NUM'")

SYM_MELT=$($PSQL "SELECT melting_point_celsius FROM properties FULL JOIN elements ON properties.atomic_number = elements.atomic_number WHERE properties.ref='$SYM_NUM'")

SYM_BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties FULL JOIN elements ON properties.atomic_number=elements.atomic_number WHERE properties.ref='$SYM_NUM'")

SYM_TYPE=$($PSQL "SELECT type FROM types FULL JOIN properties ON types.type_id = properties.type_id WHERE properties.ref='$SYM_NUM'")

  echo "The element with atomic number $SYM_NUM is $SYM_NAME ($GET_SYMBOL). It's a $SYM_TYPE, with a mass of $SYM_MASS amu. $SYM_NAME has a melting point of $SYM_MELT celsius and a boiling point of $SYM_BOIL celsius."
      fi

  else 
NAME_NUM=$($PSQL "SELECT ref FROM elements WHERE name='$GET_NAME'")

NAME_SYM=$($PSQL "SELECT symbol FROM elements WHERE name='$GET_NAME'")

NAME_MASS=$($PSQL "SELECT atomic_mass FROM properties FULL JOIN elements ON properties.atomic_number = elements.atomic_number WHERE properties.ref='$NAME_NUM'")

NAME_MELT=$($PSQL "SELECT melting_point_celsius FROM properties FULL JOIN elements ON properties.atomic_number = elements.atomic_number WHERE properties.ref='$NAME_NUM'")

NAME_BOIL=$($PSQL "SELECT boiling_point_celsius FROM properties FULL JOIN elements ON properties.atomic_number=elements.atomic_number WHERE properties.ref='$NAME_NUM'")

NAME_TYPE=$($PSQL "SELECT type FROM types FULL JOIN properties ON types.type_id = properties.type_id WHERE properties.ref='$NAME_NUM'")

  echo "The element with atomic number $NAME_NUM is $GET_NAME ($NAME_SYM). It's a $NAME_TYPE, with a mass of $NAME_MASS amu. $GET_NAME has a melting point of $NAME_MELT celsius and a boiling point of $NAME_BOIL celsius."
  fi
fi


#if app init included input, read it


#get element available


#If you run ./element.sh 1
  #The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.
  #The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.

#./element.sh H, o
  #The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius
  #The element with atomic number 1 is Hydrogen(H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.

#./element.sh Hydrogen
  #The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius
  #The element with atomic number 1 is Hydrogen (H). It's a nonmetal, with a mass of 1.008 amu. Hydrogen has a melting point of -259.1 celsius and a boiling point of -252.9 celsius.