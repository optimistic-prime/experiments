#!/bin/bash

input_file=$1
output_file=$2

if [ -z $1 ]
then
    echo
    echo "usage:"
    echo
    echo "    ./gen_passwds.sh input_file output_file"
    echo
    exit 1 
fi

while IFS= read -r line
do

    LONG_PASSWD=`uuidgen`
    SHORT_PASSWD=`< /dev/urandom tr -dc A-Za-z0-9 | head -c 15`
    (sed -e "s~{LONG_PASSWORD}~$LONG_PASSWD~g" \
      -e"s~{SHORT_PASSWORD}~$SHORT_PASSWD~g") <<< $line

done < $input_file > $output_file

echo "Edits still needed:
  . COMPANY
  . NFS_ID
  . SLUG
  . COMPANY_WITH_GRAMMAR
"
