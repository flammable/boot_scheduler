USE_PKGBUILD=1
include /usr/local/share/luggage/luggage.make
TITLE=boot_scheduler_dates
REVERSE_DOMAIN=edu.sju
PAYLOAD=\
	pack-Library-Management-boot_scheduler_dates.txt

munkiimport: pkg
		munkiimport \
--nointeractive \
--subdirectory scripts \
--name "${TITLE}" \
--displayname "Boot Scheduler - Dates" \
--description "Contains a list of dates for Boot Scheduler." \
--category "Scripts" \
--developer "Saint Joseph's University" \
--minimum_os_version "10.10.5" \
--update_for "boot_scheduler" \
--unattended_install \
"${PACKAGE_FILE}"