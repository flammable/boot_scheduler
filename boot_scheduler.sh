#!/bin/bash

cut="/usr/bin/cut"
date="/bin/date"
echo="/bin/echo"
grep="/usr/bin/grep"
python="/usr/bin/python"
shutdown="/sbin/shutdown"

POWEROFF="/Library/SJU/boot_schedule_off.txt"
TODAY=$(${date} "+%Y"-"%m"-"%d")
CURRENTUSER=$(${python} -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')

# Checks for the hour of the time only; cuts to format (HH)
SystemHour=$(${date} "+TIME:: %H" | ${cut} -c 8-9)

# Hour of time we have set computers to turn on (HH) done this way so it'll only run within that hour
TurnOnTime=04

if [ "$SystemHour" = "$TurnOnTime" ] ; then
	${echo} "Boot Scheduler: Turn On Time is within the hour."
		if $(${grep} -q "$TODAY" "$POWEROFF"); then
			${echo} "Boot Scheduler: Today is a holiday."
				if [ -z ${CURRENTUSER} ] ; then
					${echo} "Boot Scheduler: Nobody is logged in. Shutting down."
					${shutdown} -h now
				else
					${echo} "Boot Scheduler: This computer is in use. Exiting."
					exit 0
				fi
		else
			${echo} "Boot Scheduler: Today is not a holiday."
			exit 0
		fi	
else
	${echo} "Boot Scheduler: This script is running outside of the Turn On Time. Exiting."
	exit 0
fi
${echo} "Boot Scheduler: Something unexpected happened. Exiting."
exit 0
