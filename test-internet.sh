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
if ! $(curl --output /dev/null --silent --head --fail http://$HOST:$PORT)
then
  logger -i -p $FACILITY -t $TAG "Internet Unreachable"
fi



