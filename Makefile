USE_PKGBUILD=1
include /usr/local/share/luggage/luggage.make
TITLE=boot_scheduler
REVERSE_DOMAIN=edu.sju
PAYLOAD=\
	pack-Library-LaunchDaemons-edu.sju.boot_scheduler.plist\
	pack-usr-local-bin-boot_scheduler.sh\
	pack-Library-SJU-boot_schedule_off.txt\
	pack-script-postinstall

munkiimport: dmg
		munkiimport \
--nointeractive \
--subdirectory scripts \
--name "${TITLE}" \
--displayname "Boot Scheduler" \
--description "Boots the machine at 4 AM. Powers off on designated days." \
--category "Scripts" \
--developer "Saint Joseph's University" \
--minimum_os_version "10.10.5" \
--RestartAction "RequireRestart" \
--postuninstall_script ./munki_postuninstall_script.sh \
"${DMG_NAME}"