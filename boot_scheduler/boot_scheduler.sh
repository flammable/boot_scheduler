#!/bin/bash

cut="/usr/bin/cut"
date="/bin/date"
echo="/bin/echo"
grep="/usr/bin/grep"
pmset="/usr/bin/pmset"
python="/usr/bin/python"
shutdown="/sbin/shutdown"

POWEROFF="/Library/Management/boot_scheduler_dates.txt"
TODAY=$(${date} "+%Y"-"%m"-"%d")
CURRENTUSER=$(${python} -c 'from SystemConfiguration import SCDynamicStoreCopyConsoleUser; import sys; username = (SCDynamicStoreCopyConsoleUser(None, None, None) or [None])[0]; username = [username,""][username in [u"loginwindow", None, u""]]; sys.stdout.write(username + "\n");')

# Ensure pmset schedule is set
${pmset} repeat wakeorpoweron MTWRFSU 04:00:00
${pmset} autorestart 1

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
