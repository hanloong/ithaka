#!/bin/sh
if [ "$BRANCH" == "master" ]
then
  echo "Deploying ithka $BRANCH"
  curl "https://portal.ninefold.com/api/v1/apps/8108/redeploy?auth_token=4MMIGXynd-lXbU0HHJYpyg"
fi
