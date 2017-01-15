#!/bin/bash

# no need to mirror gradle, https://services.gradle.org/distributions/gradle-2.1-bin.zip
# it doesn't download when internet is unavailable, and android studio works just fine

# http://stackoverflow.com/questions/242538/unix-shell-script-find-out-which-directory-the-script-file-resides
BASEDIR=$(dirname $0)

# The list of xml files was copied from Android Studio 2.2.3 >> Settings >> Appearance & Behavior >> System Settings >> Android SDK >> SDK Update Sites
# https://dl.google.com/android/repository/repository2-1.xml
# https://dl.google.com/android/repository/sys-img/android/sys-img2-1.xml
# https://dl.google.com/android/repository/sys-img/android-tv/sys-img2-1.xml
# https://dl.google.com/android/repository/sys-img/android-wear/sys-img2-1.xml
# https://dl.google.com/android/repository/glass/addon2-1.xml
# https://dl.google.com/android/repository/sys-img/google_apis/sys-img2-1.xml
# https://dl.google.com/android/repository/addon2-1.xml
# https://dl.google.com/android/repository/extras/intel/addon2-1.xml

sites=(
	"android/repository/repository2-1"
	"android/repository/sys-img/android/sys-img2-1"
	"android/repository/sys-img/android-tv/sys-img2-1"
	"android/repository/sys-img/android-wear/sys-img2-1"
	"android/repository/glass/addon2-1"
	"android/repository/sys-img/google_apis/sys-img2-1"
	"android/repository/addon2-1"
	"android/repository/extras/intel/addon2-1"
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

echo verifying
grep -rn '<sdk:url>' * --include=*2-1.xml --exclude-dir=orig | grep http

echo studio and sdk tools
sh ${BASEDIR}/studio.sh

echo httpd conf
cat ${BASEDIR}/apache2.conf | sed "s/hu.dushu.studyjams/`pwd | sed 's/\\//\\\\\\//g'`/g" > and-repo.apache2.conf
echo 'include and-repo.apache2.conf in your apache httpd.conf file (or a file included by it, e.g. httpd-vhosts.conf)'
cat and-repo.apache2.conf
