#/bin/bash

length=${#1}
#echo $length

if [[ $1 == "" ]]; then
  echo "Usage: ./Telephone-Keypad.sh TEXT"
  exit
fi

for ((i = 0; i < $length; i++)); do
  array1+=(${1:$i:1})

  if [[ ${1:$i:1} == [a-cA-C] ]]; then
    array2+=2
  elif [[ ${1:$i:1} == [d-fD-F] ]]; then
    array2+=3
  elif [[ ${1:$i:1} == [g-iG-I] ]]; then
    array2+=4
  elif [[ ${1:$i:1} == [j-lJ-L] ]]; then
    array2+=5
  elif [[ ${1:$i:1} == [m-oM-O] ]]; then
    array2+=6
  elif [[ ${1:$i:1} == [p-sP-S] ]]; then
    array2+=7
  elif [[ ${1:$i:1} == [t-vT-V] ]]; then
    array2+=8
  elif [[ ${1:$i:1} == [w-zW-Z] ]]; then
    array2+=9
  fi
done

printf %s "${array1[@]}${array2[@]}" $'\n'
