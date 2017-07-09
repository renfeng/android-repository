#!/bin/bash

# no need to mirror gradle, https://services.gradle.org/distributions/gradle-2.1-bin.zip
# it doesn't download when internet is unavailable, and android studio works just fine

# http://stackoverflow.com/questions/242538/unix-shell-script-find-out-which-directory-the-script-file-resides
BASEDIR=$(dirname $0)

# https://android.googlesource.com/platform/sdk/+/tools_r14
# The URL ends with a /, allowing easy concatenation.
DL_HOST=${DL_HOST:-https://dl.google.com}
DL_PATH=${DL_PATH:-android/repository}

echo synchronizing indices
sites=()

# TODO auto increment
site=repository2-1
# http://stackoverflow.com/questions/4944295/wget-skip-if-files-exist/16840827#16840827
# http://stackoverflow.com/questions/16153446/bash-last-index-of/16153529#16153529
wget -N ${DL_HOST}/${DL_PATH}/${site}.xml -P ${DL_PATH}
sites+=(${site})

# TODO auto increment
site=addons_list-3
wget -N ${DL_HOST}/${DL_PATH}/${site}.xml -P ${DL_PATH}
sites+=(${site})

while read -r site; do
	SUB_PATH=`expr match ${site} '\(.*/\)'`
	wget -N ${DL_HOST}/${DL_PATH}/${site}.xml -P ${DL_PATH}/${SUB_PATH}
	sites+=(${site})
done <<< "`cat ${DL_PATH}/${site}.xml | perl -nle 'print $& if m{(?<=<url>).*(?=</url>)}' | sed s/.xml//g`"

echo downloading packages
# TODO filter obsolete
for site in ${sites[@]}; do
	echo ${site}
	SUB_PATH=`expr match ${site} '\(.*/\)'`
	cat ${DL_PATH}/${site}.xml | perl -nle 'print $& if m{(?<=<url>).*(?=</url>)}' | sed "s~^~${DL_HOST}/${DL_PATH}/${SUB_PATH}~g" | wget -N -P ${DL_PATH}/${SUB_PATH} -c -i -
done

echo studio and sdk tools
${BASEDIR}/studio.sh

echo httpd conf
cat ${BASEDIR}/apache2.conf | sed "s/hu.dushu.studyjams/`pwd | sed 's/\\//\\\\\\//g'`/g" > and-repo.apache2.conf
echo 'include and-repo.apache2.conf in your apache httpd.conf file (or a file included by it, e.g. httpd-vhosts.conf)'
cat and-repo.apache2.conf

# clean obsolete
echo android/repository/repository2-1.xml >> ${DL_PATH}/valid
echo android/repository/addons_list-3.xml >> ${DL_PATH}/valid
for site in ${sites[@]}; do
	SUB_PATH=`expr match ${site} '\(.*/\)'`
	cat ${DL_PATH}/${site}.xml | perl -nle 'print $& if m{(?<=<url>).*(?=</url>)}' | sed "s~^~${DL_PATH}/${SUB_PATH}~g" >> ${DL_PATH}/valid
done
valid="`cat ${DL_PATH}/valid`"
while read -r file; do
	if ! echo "${valid}" | grep -q ${file}; then
		rm ${file}
	fi
done <<< "`find ${DL_PATH} -type f`"
