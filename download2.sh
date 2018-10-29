#!/bin/bash

# no need to mirror gradle, https://services.gradle.org/distributions/gradle-2.1-bin.zip
# it doesn't download when internet is unavailable, and android studio works just fine

# http://stackoverflow.com/questions/242538/unix-shell-script-find-out-which-directory-the-script-file-resides
basedir=$(dirname $0)

DL_HOST=${DL_HOST:-https://dl.google.com}
DL_PATH=android/repository

# TODO auto increment 2-1 and 3
GENERAL_SITE=repository2-1
ADDON_SITE_INDEX=addons_list-3

echo synchronizing indices

# http://stackoverflow.com/questions/4944295/wget-skip-if-files-exist/16840827#16840827
# http://stackoverflow.com/questions/16153446/bash-last-index-of/16153529#16153529
wget -N ${DL_HOST}/${DL_PATH}/${ADDON_SITE_INDEX}.xml -P ${DL_PATH}

sites=(${GENERAL_SITE})
while read -r addon_site; do
	sites+=(${addon_site})
done <<< "`cat ${DL_PATH}/${ADDON_SITE_INDEX}.xml | perl -nle 'print $& if m{(?<=<url>).*(?=</url>)}' | sed s/.xml//g`"

for site in ${sites[@]}; do
	sub_path=`echo ${site} | perl -nle 'print $& if m{.*/|}'`
	wget -N ${DL_HOST}/${DL_PATH}/${site}.xml -P ${DL_PATH}/${sub_path}
done

echo downloading packages

for site in ${sites[@]}; do
	echo ${site}
	sub_path=`echo ${site} | perl -nle 'print $& if m{.*/|}'`
	cat ${DL_PATH}/${site}.xml | perl -nle 'print $& if m{(?<=<url>).*(?=</url>)}' | sed "s~^~${DL_HOST}/${DL_PATH}/${sub_path}~g" | wget -N -P ${DL_PATH}/${sub_path} -c -i -
done

# TODO generating sdk web manager data

echo removing obsolete files
echo ${DL_PATH}/${ADDON_SITE_INDEX}.xml > ${DL_PATH}/downloaded
for site in ${sites[@]}; do
	sub_path=`echo ${site} | perl -nle 'print $& if m{.*/|}'`
	echo ${DL_PATH}/${site}.xml >> ${DL_PATH}/downloaded
	cat ${DL_PATH}/${site}.xml | perl -nle 'print $& if m{(?<=<url>).*(?=</url>)}' | sed "s~^~${DL_PATH}/${sub_path}~g" >> ${DL_PATH}/downloaded
done
downloaded=`cat ${DL_PATH}/downloaded`
while read -r file; do
	if ! echo "${downloaded}" | grep -q ${file}; then
		echo ${file}
		rm ${file}
	fi
done <<< "`find ${DL_PATH} -type f -not -path android/repository/downloaded`"

echo
echo httpd conf
echo 'include the following lines in your apache httpd.conf file (or a file included by it, e.g. httpd-vhosts.conf)'
cat ${basedir}/apache2.conf | sed "s/hu.dushu.studyjams/`pwd | sed 's/\\//\\\\\\//g'`/g"
