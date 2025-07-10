#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

# check if argument is provided
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit
fi

# identify if input is atomic number, symbol, or name
if [[ $1 =~ ^[0-9]+$ ]]
then
  ELEMENT_DATA=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius 
                        FROM elements 
                        INNER JOIN properties USING(atomic_number) 
                        INNER JOIN types USING(type_id) 
                        WHERE atomic_number = $1")
else
  ELEMENT_DATA=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius 
                        FROM elements 
                        INNER JOIN properties USING(atomic_number) 
                        INNER JOIN types USING(type_id) 
                        WHERE symbol = INITCAP('$1') OR name = INITCAP('$1')")
fi

# handle if element not found
if [[ -z $ELEMENT_DATA ]]
then
  echo "I could not find that element in the database."
  exit
fi

# parse and display output
IFS="|" read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MP BP <<< "$ELEMENT_DATA"

echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius."
