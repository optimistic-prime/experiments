#!/bin/bash
set -e

RELEASE_NUMBER=$1
BRANCH="v3.2"

RN_COUNT=$(echo $1 | wc -c)
echo $RN_COUNT

if [[ ! "$RELEASE_NUMBER" =~ ^[0-9]+(\.[0-9]+)+(\.[0-9]+) ]]
then
  echo 'Command improperly run, usage:'
  echo './<file>.sh 3.2.30'
  exit 1
fi

echo "
  RELEASE_NUMBER: $RELEASE_NUMBER
          BRANCH: $BRANCH
"

# package requirements:
# sudo snap install yq

(
  # need env vars for code and unsupervised folder paths
  # ie. on AR's computer: code=/home/alex/code/repos/code

  #######################################################
  # Get hash for commit in code repo
  #######################################################
  echo; echo 'Getting code hash'
  cd $code
  git checkout $BRANCH
  git pull

  NEW_HASH=$(git rev-parse HEAD)
  echo; echo "new hash:"; echo "$NEW_HASH"; echo


  #######################################################
  # Replace unsupervised images.yaml hash
  #######################################################
  echo; echo 'Replacing unsupervised images hash'
  cd $unsupervised
  git checkout $BRANCH
  git pull
  git checkout -b $BRANCH-$RELEASE_NUMBER

  CURRENT_HASH=$(cat images.yaml | yq -r .global.images.kbe.tag)
  sed -i "s/$CURRENT_HASH/$NEW_HASH/g" images.yaml
  echo 'hash replacement complete'

  git push --set-upstream origin $BRANCH-$RELEASE_NUMBER


  #######################################################
  # Replace Chart.yaml version and appVersion
  #######################################################
  echo; echo 'Replacing unsupervised versions'
  cd $unsupervised

  echo; echo 'update version'
  yq -yi ".version = \"$RELEASE_NUMBER\"" unsupervised/Chart.yaml
  echo; echo 'update appVersion'
  yq -yi ".appVersion = \"$RELEASE_NUMBER\"" unsupervised/Chart.yaml


  #######################################################
  # Creating PR for new release in unsupervised repo
  #######################################################
  cd $unsupervised
  git pull
  git add -A
  git commit -m "commit for release ${RELEASE_NUMBER}"
  echo; echo "pushing to unsupervised, $BRANCH-$RELEASE_NUMBER"
  git push --set-upstream origin $BRANCH-$RELEASE_NUMBER

  echo; echo 'Please create a PR here: https://github.com/Unsupervisedcom/unsupervised/pulls'
)
