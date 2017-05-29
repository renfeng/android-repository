#!/bin/bash

# no need to mirror gradle, https://services.gradle.org/distributions/gradle-2.1-bin.zip
# it doesn't download when internet is unavailable, and android studio works just fine

# http://stackoverflow.com/questions/242538/unix-shell-script-find-out-which-directory-the-script-file-resides
BASEDIR=$(dirname $0)

# The list of xml files was extracted from Android SDK Manager log (sample: sdk-mgr.log)

# The following two are the meta indices most up to date, and supported, as of 2017-01-15
# http://dl.google.com/android/repository/addons_list-2.xml
# http://dl.google.com/android/repository/repository-11.xml

# Everything else that follows
# http://dl.google.com/android/repository/addon-6.xml
# http://dl.google.com/android/repository/addon.xml
# http://dl.google.com/android/repository/extras/intel/addon.xml
# http://dl.google.com/android/repository/glass/addon.xml
# http://dl.google.com/android/repository/sys-img/android-tv/sys-img.xml
# http://dl.google.com/android/repository/sys-img/android-wear/sys-img.xml
# http://dl.google.com/android/repository/sys-img/android/sys-img.xml
# http://dl.google.com/android/repository/sys-img/google_apis/sys-img.xml
# http://dl.google.com/android/repository/sys-img/x86/addon-x86.xml

# The list will be saved by Android SDK Manager, and retrievable with the following command line
# http://www.gnu.org/savannah-checkouts/gnu/grep/manual/grep.html
#grep -Po '(?<=@name@).*/android/repository/.*(?==)' ~/.android/sites-settings.cfg | sed 's/\\//g'

sites=(
	"android/repository/repository-11"
	"android/repository/addon-6"
	"android/repository/addon"
	"android/repository/extras/intel/addon"
	"android/repository/glass/addon"
	"android/repository/sys-img/android-tv/sys-img"
	"android/repository/sys-img/android-wear/sys-img"
	"android/repository/sys-img/android/sys-img"
	"android/repository/sys-img/google_apis/sys-img"
	"android/repository/sys-img/x86/addon-x86"
)

echo synchronizing indices
# http://stackoverflow.com/questions/4944295/wget-skip-if-files-exist/16840827#16840827
# http://stackoverflow.com/questions/16153446/bash-last-index-of/16153529#16153529
for site in ${sites[@]}; do
	wget -N http://dl.google.com/${site}.xml -P orig/${site%/*}
done

echo downloading packages
# http://www.sagehill.net/docbookxsl/InstallingAProcessor.html#cygwin
for site in ${sites[@]}; do
	echo ${site}
	xsltproc ${BASEDIR}/${site}.xsl orig/${site}.xml | sed 's/https:/http:/g' | wget -N -P ${site%/*} -c -i -
done

echo localizing indices
for site in ${sites[@]}; do
	mkdir -p ${site%/*}
	cat orig/${site}.xml | sed 's/https:\/\/dl.google.com//g' > ${site}.xml
done

echo generating sdk web manager data
echo "name,version,api-level,revision,description,obsolete,windowsSize,windowsSHA1,windowsURL,macosxSize,macosxSHA1,macosxURL,linuxSize,linuxSHA1,linuxURL" \
	> packages.csv.tmp
for site in ${sites[@]}; do
	xsltproc ${BASEDIR}/${site}.csv.xsl orig/${site}.xml >> packages.csv.tmp
done
mv packages.csv.tmp packages.csv

echo removing obsolete sdk packages
# TODO grep -P is not supported by OS X
grep true packages.csv \
	| grep -Po '(?<=https://dl-ssl[.]google[.]com/)[^,]+|(?<=https://dl[.]google[.]com/)[^,]+' \
	| sed -E 's/^(.*)$/rm -f \1/g' \
	> clean-obsolete.sh
sh clean-obsolete.sh

echo verifying
grep -rn '<sdk:url>' * --include=*.xml --exclude-dir=orig | grep http

echo studio and sdk tools
sh ${BASEDIR}/studio.sh

echo httpd conf
cat ${BASEDIR}/apache2.conf | sed "s/hu.dushu.studyjams/`pwd | sed 's/\\//\\\\\\//g'`/g" > and-repo.apache2.conf
echo 'include and-repo.apache2.conf in your apache httpd.conf file (or a file included by it, e.g. httpd-vhosts.conf)'
cat and-repo.apache2.conf
