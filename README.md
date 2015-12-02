# boot_scheduler

### What is this?

This is a script, a launchd item, and a text file to power on and off Macs based on a calendar.

### Why does this exist?

The excellent `pmset` tool can be used to schedule a Mac to power on (or wake) based on the time of day, or day of the week.  However, it has no recognition of calendar dates, such as December 25th.

We manage our Macs with Munki, and want all labs and podiums to be powered on every day - that way, they receive regular software updates.  Sometimes, lab Macs will stay powered off for weeks or months at a time, and when they're turned on, they're missing stability or security updates.

### How does it work?

In the postinstall script, the Mac is set to boot or wake at 4 AM every day.  The LaunchDaemon, `edu.sju.boot_scheduler.plist`, triggers at 4 AM, and runs `boot_scheduler.sh`.  `boot_scheduler.sh` shuts down the Mac if it meets all of the following conditions:

* The current time is between 4 AM and 5 AM.
* The calendar date is a holiday, as defined in `boot_schedule_off.txt`.
* No user is currently logged into the machine.

If any of these conditions are not met, the script exits without doing anything.

### How do I use this?

We use [Munki](https://github.com/munki/munki) and [The Luggage](https://github.com/unixorn/luggage), so the package is built accordingly.  Just `cd` into the directory, then `make munkiimport`.  I recommend that you edit `boot_schedule_off.txt`, at the very least.

You can also place the files where they need to go manually, or using another tool.

### Requirements

As all of our labs and podiums are running OS X 10.10.5, I haven't tested any other versions of the OS.  It should work fine on 10.9.x and lower, but please test.

### Credits

* boot_scheduler.sh started life as a script from [jmartinez0837's Munki Overnight script](https://github.com/jmartinez0837/Munki-Overnight).
* edu.sju.boot_scheduler.plist was adapted from [gmarnin's profile deletion script](https://gist.github.com/gmarnin/bfa800c4bbf65eee1d09).