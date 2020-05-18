#!/bin/bash

SLUG=$1
ACCOUNT_ID=`aws sts get-caller-identity --query Account --output text`

if [ -z $1 ]
then
    echo
    echo "usage:"
    echo
    echo "    ./update_vars.sh slug"
    echo
    exit 1 
fi

FILES=('readme' 'cluster-singleton.yaml' 'unsupervised-values.yaml')
for FILE in ${FILES[@]}; do
    while IFS= read -r line
    do
    
        echo "$line"
        LONG_PASSWD=`uuidgen`
        SHORT_PASSWD=`< /dev/urandom tr -dc A-Za-z0-9 | head -c 15`
        (sed -e "s~{LONG_PASSWORD}~$LONG_PASSWD~g" \
          -e "s~{SLUG}~$SLUG~g" \
          -e "s~{ACCOUNT_ID}~$ACCOUNT_ID~g" \
          -e"s~{SHORT_PASSWORD}~$SHORT_PASSWD~g") <<< $line
    
    done < $FILE > $FILE
done
    
echo "Edits still needed:
  . COMPANY
  . NFS_ID
  . COMPANY_WITH_GRAMMAR
"
