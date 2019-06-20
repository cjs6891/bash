#/bin/bash

length=${#1}

array0=('A - Alfa'
'B - Bravo'
'C - Charlie'
'D - Delta'
'E - Echo'
'F - Foxtrot'
'G - Golf'
'H - Hotel'
'I - India'
'J - Juliett'
'K - Kilo'
'L - Lima'
'M - Mike'
'N - November'
'O - Oscar'
'P - Papa'
'Q - Quebec'
'R - Romeo'
'S - Sierra'
'T - Tango'
'U - Uniform'
'V - Victor'
'W - Whiskey'
'X - X-ray'
'Y - Yankee'
'Z - Zulu'
'0 - Zero'
'1 - One'
'2 - Two'
'3 - Three'
'4 - Four'
'5 - Five'
'6 - Six'
'7 - Seven'
'8 - Eight'
'9 - Nine'
'& - Ampersand / And'
"' - Apostrophe / Single Quote"
'* - Asterisk'
'@ - At'
'` - Back Quote'
'\ - Back Slash'
'^ - Carat'
'} - Close Brace'
'] - Close Bracket'
') - Close Parenthesis'
': - Colon'
', - Comma'
'- - Dash / Hyphen / Minus '
'$ - Dollar'
'. - Dot / Period'
'" - Double Quote'
'= - Equal'
'! - Exclamation Mark'
'/ - Forward Slash'
'> - Greater Than'
'# - Hash / Pound'
'< - Less Than'
'{ - Open Brace'
'[ - Open Bracket'
'( - Open Parenthesis'
'% - Percent'
'| - Pipe'
'+ - Plus'
'? - Question Mark'
'; - Semi-Colon'
'~ - Tilde'
'_ - Underscore'
)

if [[ $1 == "" ]]; then
  echo "Usage: ./NATO-Phonetic-Alphabet.sh TEXT -or- ./NATO-Phonetic-Alphabet.sh 'STRING'"
  echo ""
  echo "Examples:"
  echo "./NATO-Phonetic-Alphabet.sh user@example.com"
  echo "./NATO-Phonetic-Alphabet.sh 'Hello World.'"
  exit
fi

for ((i = 0; i < $length; i++)); do
  j=`echo "${1:$i:1}" | tr a-z A-Z`
  array1+=$j
  if [[ $j == "*" ]]; then
    k=`printf '%s\n' "${array0[@]}" | grep -E '^\*\ \-'`
    array2+=("$k")
  elif [[ $j == "^" ]]; then
    k=`printf '%s\n' "${array0[@]}" | grep -E '^\^\ \-'`
    array2+=("$k")
  elif [[ $j == ")" ]]; then
    k=`printf '%s\n' "${array0[@]}" | grep -E '^\)\ \-'`
    array2+=("$k")
  elif [[ $j == "." ]]; then
    k=`printf '%s\n' "${array0[@]}" | grep -E '^\.\ \-'`
    array2+=("$k")
  elif [[ $j == "[" ]]; then
    k=`printf '%s\n' "${array0[@]}" | grep -E '^\[\ \-'`
    array2+=("$k")
  elif [[ $j == "(" ]]; then
    k=`printf '%s\n' "${array0[@]}" | grep -E '^\(\ \-'`
    array2+=("$k")
  elif [[ $j == "|" ]]; then
    k=`printf '%s\n' "${array0[@]}" | grep -E '^\|\ \-'`
    array2+=("$k")
  elif [[ $j == "+" ]]; then
    k=`printf '%s\n' "${array0[@]}" | grep -E '^\+\ \-'`
    array2+=("$k")
  elif [[ $j == "?" ]]; then
    k=`printf '%s\n' "${array0[@]}" | grep -E '^\?\ \-'`
    array2+=("$k")
  else
    k=`printf '%s\n' "${array0[@]}" | grep -E "^$j"`
    array2+=("$k")
  fi
done

printf %s "${array1[@]}" $'\n'
printf '%s\n' "${array2[@]}"
