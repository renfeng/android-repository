#!/bin/bash

# TODO automate the update of studio version, e.g. 2.2.3.0 as of 2017-01-15

# http://stackoverflow.com/questions/242538/unix-shell-script-find-out-which-directory-the-script-file-resides
BASEDIR=$(dirname $0)

DL_HOST=${DL_HOST:-https://dl.google.com}
DL_PATH=android/studio

# available options for language (as of 2017-07-28)
# id - Bahasa Indonesia
# de - Deutsch
# en - English
# es - español
# es-419 - Español (América Latina)
# fr - français
# pt-br - Português Brasileiro
# vi - Tiếng Việt
# tr - Türkçe
# ru - Русский
# th - ภาษาไทย
# ja - 日本語
# zh-cn - 简体中文
# zh-tw - 繁體中文
# ko - 한국어
DL_LANG=${DL_LANG:-en}

mkdir -p ${DL_PATH}

# android_developer_pref_lang is ignored
# TODO the column header of checksum is incorrent for Chinese: SHA-1 checksum (should be SHA-256 checksum)
# https://www.gnu.org/software/wget/manual/html_node/HTTP-Options.html
wget --header "Cookie: django_language=${DL_LANG}" --no-check-certificate https://developer.android.com/studio/index.html -O ${DL_PATH}/index.html.orig

# download android studio
grep -o ${DL_HOST}/dl/${DL_PATH}'/[^"]*' ${DL_PATH}/index.html.orig | grep -v [.]exe \
  | sed -E 's~('${DL_HOST}'/dl/('${DL_PATH}'/[^/]+/[^/]+)/.+)~wget -N -c \1 -P \2~g' \
  > ${DL_PATH}/download.sh
chmod +x ${DL_PATH}/download.sh
${DL_PATH}/download.sh

# download sdk tools
grep -o ${DL_HOST}/android/repository/'[^"]*' ${DL_PATH}/index.html.orig | wget -N -P android/repository -c -i -

## generate download page
## sed remove lines until
## http://www.linuxquestions.org/questions/linux-newbie-8/how-to-use-sed-to-delete-all-lines-before-the-first-match-of-a-pattern-802069/
## sed remove lines after
## http://stackoverflow.com/questions/5227295/how-do-i-delete-all-lines-in-a-file-starting-from-after-a-matching-line
#cat ${DL_PATH}/index.html.orig \
#  | sed -n '/<section id="downloads"/,$p' \
#  | sed '/section>/q' \
#  > ${DL_PATH}/index.html.sections
#cat ${DL_PATH}/index.html.orig \
#  | sed -n '/<section id="Requirements"/,$p' \
#  | sed '/section>/q' \
#  >> ${DL_PATH}/index.html.sections
#
#cat ${BASEDIR}/${DL_PATH}/template.html \
#             | sed '/<!-- insert -->/q' \
#             > ${BASEDIR}/docs/${DL_PATH}/index.html
#cat ${DL_PATH}/index.html.sections \
#      | sed -E "s~${DL_HOST}(/dl)?~~g" \
#      | sed 's~onclick="return onDownload(this)"~target="_blank"~g' \
#      >> ${BASEDIR}/docs/${DL_PATH}/index.html
#cat ${BASEDIR}/${DL_PATH}/template.html \
#            | sed -n '/<!-- insert -->/,$p' \
#            >> ${BASEDIR}/docs/${DL_PATH}/index.html

# clean sdk manager
grep -o ${DL_HOST}/android/repository/'[^"]*' ${DL_PATH}/index.html.orig | grep -v [.]exe \
  | sed -E 's~'${DL_HOST}'/~~g' >> android/repository/valid

# clean obsolete studio
grep -o ${DL_HOST}/dl/${DL_PATH}'/[^"]*' ${DL_PATH}/index.html.orig | grep -v [.]exe \
  | sed -E 's~'${DL_HOST}'/dl/('${DL_PATH}'/.+)~\1~g' >> ${DL_PATH}/valid
valid=`cat ${DL_PATH}/valid`
while read -r file; do
	if ! echo "${valid}" | grep -q ${file}; then
		rm ${file}
	fi
done <<< "`find ${DL_PATH} -type f`"

pushd ${BASEDIR}/docs/android

popd
# https://superuser.com/questions/61611/how-to-copy-with-cp-to-include-hidden-files-and-hidden-directories-and-their-con/367303#367303
cp -r ${BASEDIR}/docs/. .
