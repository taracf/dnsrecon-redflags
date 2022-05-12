#!/bin/sh
while read item; do
  domain=$(dig @8.8.8.8  -x "$item" +short)
  if [ -n "$domain"  ]; then
    if echo "$domain" | grep -q -i -e ".mil" -e ".gov"; then
      echo "\033[33;31m [WARNING] \033[0m $domain"
    elif echo "$domain" | grep -v -q "$2"; then
      echo "\033[33;33m [NOMATCH] \033[0m $domain"
    else
      echo "\033[33;32m [MATCH] \033[0m $domain"
    fi
  else
    echo "\033[33;33m [NOMATCH] \033[0m $item - No rDNS found"
  fi
done <$1
