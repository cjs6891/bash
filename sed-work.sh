#!/bin/bash

_FILE=./a.txt

_ALFA="Spicy jalapeno bacon"
_BRAVO="HelloWorld."

## REPLACE ENTIRE LINE WHEN MATCH FOUND
sed "s/^$_ALFA.*/$_BRAVO/g" $_FILE

echo ""
echo "#########################"
echo ""

## REPLACE FIRST OCCURRENCE WHEN MATCH FOUND
## W/THE -z OPTION SED TREATS THE ENTIRE FILE AS A SINGLE LINE
#sed -zi "s/$_ALFA/$_BRAVO/" $_FILE
sed -z "s/$_ALFA/$_BRAVO/" $_FILE

echo ""
echo "#########################"
echo ""

## INSERT LINE BEFORE MATCH FOUND
sed "/^$_ALFA/i $_BRAVO" $_FILE

echo ""
echo "#########################"
echo ""

## INSERT LINE AFTER MATCH FOUND
sed "/^$_ALFA/a $_BRAVO" $_FILE
