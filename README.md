# Boot Scheduler

### What is this?

This is a tool to power on and off Macs based on calendar dates.

### Why does this exist?

The excellent `pmset` tool can be used to schedule a Mac to power on (or wake) based on the time of day, or day of the week.  However, it has no recognition of calendar dates, such as December 25th.

We manage our Macs with Munki, and want all labs and podiums to be powered on every day - that way, they receive regular software updates.  Sometimes, lab Macs will stay powered off for weeks or months at a time, and when they're turned on, they're missing stability or security updates.

### How does it work?

Boot Scheduler is comprised of two packages - `boot_scheduler` contains the launchd item, and requires a reboot for installation. `boot_scheduler_dates` contains the list of dates, and can be installed without requiring a reboot.

In the postinstall script, the Mac is set to boot or wake at 4 AM every day.  The LaunchDaemon, `edu.sju.boot_scheduler.plist`, triggers at 4 AM, and runs `boot_scheduler.sh`.  `boot_scheduler.sh` shuts down the Mac if it meets all of the following conditions:

* The current time is between 4 AM and 5 AM.
* The calendar date is a holiday, as defined in `boot_scheduler_dates.txt`.
* No user is currently logged into the machine.

If any of these conditions are not met, the script exits without doing anything.

### How do I use this?

You'll need [The Luggage](https://github.com/unixorn/luggage) installed. Also, make sure you have my [luggage.local file](https://github.com/flammable/luggage_local) in place (or the relevant portions copied to your luggage.local file). We use [Munki](https://github.com/munki/munki) to deploy both packages, but it's not necessarily required.

Be sure to edit `boot_scheduler_dates.txt` to include your list of holidays!

To build both packages, `cd` into each directory and run `make dmg`, `make pkg`, or `make munkiimport`.

### Requirements

We've been using this since macOS 10.10, and I can confirm it works with macOS 10.13.

I wouldn't recommend this script for use with laptops. If you're using Munki, I'd recommend using a conditional to only deploy this to desktop Macs.

### Credits

* boot_scheduler.sh started life as a script from [jmartinez0837's Munki Overnight script](https://github.com/jmartinez0837/Munki-Overnight).
* edu.sju.boot_scheduler.plist was adapted from [gmarnin's profile deletion script](https://gist.github.com/gmarnin/bfa800c4bbf65eee1d09).