#!/bin/bash

# method for automatically encoding strings to url format
urlencode() { # 100% not taken from some repository (i forgot what tho, sorry!)
  local string="$1" 
  local length="${#string}" 
  local encoded="" 
  local i # iteration 

  for (( i = 0; i < length; i++ )); do 
    local char="${string:i:1}"
    case $char in
      [a-zA-Z0-9.~_-])
        encoded+="$char"
        ;;
      *)
        encoded+="$(printf '%%%02X' "'$char")"  
        ;;
    esac
  done

  echo "$encoded"
}

# check if any input was passed
if [ $# -eq 0 ]; then
  echo 'Usage: johnsay "<string>"'
  exit 1
fi

# run the function while passing the string, then set encoded_text to the outputted encoding
encoded_text=$(urlencode "$1")

curl -s -L "http://tts.cyzon.us/tts?text=$encoded_text" -o johnmadden.wav
# play it ( made for SoX package )
play -q johnmadden.wav
