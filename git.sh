#!/bin/sh

# Configuration:
BACKUP_DIRECTORY="/var/backup/"
DATABASE="database_name"
DATABASE_USERNAME="username"
DATABASE_PASSWORD="password"
# End of configuration.

#export PATH="/usr/bin:/usr/local/bin:$PATH"

cd $BACKUP_DIRECTORY

if [ ! -f $BACKUP_DIRECTORY.git ]
then
   git init
fi


echo -n "link remote on repos"
read link

#git remote add origin $link
#START=`date +'%m-%d-%Y %H:%M:%S'`
NOW = $(date +"%m_%d_%Y")
mysqldump -u$DATABASE_USERNAME -p$DATABASE_PASSWORD \
           --single-transaction --add-drop-table \
           $DATABASE > $DATABASE.sql

git add .
git commit -m 'update'$NOW
git remote add origin $link

git push -u origin master


#END=`date +'%m-%d-%Y %H:%M:%S'`
#CHANGES=`git diff --stat`
#SIZE=`ls -lh $DATABASE.sql | awk '{print $5}'`

#/usr/bin/git-commit -v -m "Started:  $START
#Finished: $END
#File size: $SIZE
#$CHANGES" -v $DATABASE.dump
