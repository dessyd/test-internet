#! /bin/bash
#
# One time check if Internet is reachable and log if not
#
# Must be called in a cron job
#

HOST="www.dessy.be"
PORT=80
FACILITY="syslog.warn"
TAG="network"

#
# Store Flag in the same dorectory as the script
#
FLAG=`dirname $0`/.down

hash curl 2>/dev/null || { echo >&2 "I require curl but it's not installed.  Aborting."; exit 1; }
hash logger 2>/dev/null || { echo >&2 "I require logger but it's not installed.  Aborting."; exit 1; }

if ! $(curl --output /dev/null --silent --head --fail http://$HOST:$PORT)
then
  touch $FLAG
  logger -i -p $FACILITY -t $TAG "Internet Unreachable"
else
  if [ -e $FLAG ]
  then
    rm $FLAG
    logger -i -p $FACILITY -t $TAG "Internet Restored"
  fi
fi
