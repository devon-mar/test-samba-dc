#!/bin/bash

for i in {0..2}
do
  ldapsearch -v -x -H ldap://localhost -D 'EXAMPLE\administrator' -w 'ohfie3Uahe' -b 'DC=example,DC=com' '(objectClass=user)'
  if [ "$?" -eq 0 ]; then
    exit 0
  fi
  echo "ldapsearch failed $i"
  sleep 2
done

echo "ldapsearch failed"
exit 1
