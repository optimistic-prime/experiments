#!/bin/bash

LIST=(
  ## list of aws configs
  dev-aws
  #test-aws
  #roadrunner
  #contoso
  #adp-wholesale
  #adp-chat
  #adp-711
  #cw
  #frontier
  #mercy-health
  #development
)

for i in ${LIST[@]}
do 

  AWS_PROFILE="$i" echo $i; \
    aws sts get-caller-identity --query Account --output text; \
    python scan.py; 

  echo

done
