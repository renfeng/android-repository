#!/bin/bash

# no need to mirror gradle, https://services.gradle.org/distributions/gradle-2.1-bin.zip
# it doesn't download when internet is unavailable, and android studio works just fine

# http://stackoverflow.com/questions/242538/unix-shell-script-find-out-which-directory-the-script-file-resides
BASEDIR=$(dirname $0)

DL_HOST=${DL_HOST:-https://dl.google.com}
DL_PATH=${DL_PATH:-android/repository}

echo synchronizing indices
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
	"repository-11"
	"addon-6"
	"addon"
	"extras/intel/addon"
	"glass/addon"
	"sys-img/android-tv/sys-img"
	"sys-img/android-wear/sys-img"
	"sys-img/android/sys-img"
	"sys-img/google_apis/sys-img"
	"sys-img/x86/addon-x86"
)

for site in ${sites[@]}; do
	SUB_PATH=`expr match ${site} '\(.*/\)'`
	# http://stackoverflow.com/questions/4944295/wget-skip-if-files-exist/16840827#16840827
	# http://stackoverflow.com/questions/16153446/bash-last-index-of/16153529#16153529
	wget -N ${DL_HOST}/${DL_PATH}/${site}.xml -P ${DL_PATH}/${SUB_PATH}
done

echo downloading packages
# TODO filter obsolete
for site in ${sites[@]}; do
	echo ${site}
	SUB_PATH=`expr match ${site} '\(.*/\)'`
	cat ${DL_PATH}/${site}.xml | perl -nle 'print $& if m{(?<=<sdk:url>).*(?=</sdk:url>)}' | sed "s~^~${DL_HOST}/${DL_PATH}/${SUB_PATH}~g" | wget -N -P ${DL_PATH}/${SUB_PATH} -c -i -
done

echo generating sdk web manager data
echo "name,version,api-level,revision,description,obsolete,windowsSize,windowsSHA1,windowsURL,macosxSize,macosxSHA1,macosxURL,linuxSize,linuxSHA1,linuxURL" \
	> packages.csv.tmp
for site in ${sites[@]}; do
	# http://www.sagehill.net/docbookxsl/InstallingAProcessor.html#cygwin
	xsltproc ${BASEDIR}/${DL_PATH}/${site}.csv.xsl ${DL_PATH}/${site}.xml >> packages.csv.tmp
done
mv packages.csv.tmp packages.csv

#echo removing obsolete sdk packages
## grep -P is not supported by OS X
## https://stackoverflow.com/questions/16658333/grep-p-no-longer-works-how-can-i-rewrite-my-searches
#grep true packages.csv \
#	| perl -nle 'print $& if m{(?<=https://dl-ssl[.]google[.]com/)[^,]+|(?<=https://dl[.]google[.]com/)[^,]+}' \
#	| sed -E 's/^(.*)$/rm -f \1/g' \
#	> clean-obsolete.sh
#sh clean-obsolete.sh

echo studio and sdk tools
${BASEDIR}/studio.sh

echo httpd conf
cat ${BASEDIR}/apache2.conf | sed "s/hu.dushu.studyjams/`pwd | sed 's/\\//\\\\\\//g'`/g" > and-repo.apache2.conf
echo 'include and-repo.apache2.conf in your apache httpd.conf file (or a file included by it, e.g. httpd-vhosts.conf)'
cat and-repo.apache2.conf
