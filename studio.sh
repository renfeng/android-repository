#!/bin/bash

# TODO automate the update of studio version, e.g. 2.2.3.0 as of 2017-01-15

# http://stackoverflow.com/questions/242538/unix-shell-script-find-out-which-directory-the-script-file-resides
BASEDIR=$(dirname $0)

DL_HOST=${DL_HOST:-https://dl.google.com}
DL_PATH=${DL_PATH:-android/repository}

mkdir -p studio
wget --no-check-certificate https://developer.android.com/studio/index.html -O studio/index.html.orig

# download android studio
grep -o ${DL_HOST}/dl/android/studio'/[^"]*' studio/index.html.orig | grep -v [.]exe \
  | sed -E 's~('${DL_HOST}'/('dl/android/studio'/[^/]+/[^/]+)/.+)~wget -N -P \2 -c \1~g' \
  > studio/download.sh
chmod +x studio/download.sh
studio/download.sh

# download sdk manager
grep -o ${DL_HOST}/${DL_PATH}/'[^"]*' studio/index.html.orig | grep -v [.]exe | wget -N -P ${DL_PATH} -c -i -

# generate download page
# sed remove lines until
# http://www.linuxquestions.org/questions/linux-newbie-8/how-to-use-sed-to-delete-all-lines-before-the-first-match-of-a-pattern-802069/
# sed remove lines after
# http://stackoverflow.com/questions/5227295/how-do-i-delete-all-lines-in-a-file-starting-from-after-a-matching-line
cat studio/index.html.orig \
  | sed -n '/<section id="downloads"/,$p' \
  | sed '/section>/q' \
  > studio/index.html.sections
cat studio/index.html.orig \
  | sed -n '/<section id="Requirements"/,$p' \
  | sed '/section>/q' \
  >> studio/index.html.sections

cat ${BASEDIR}/studio/template.html \
             | sed '/<!-- insert -->/q' \
             > studio/index.html
cat studio/index.html.sections \
      | sed "s~${DL_HOST}~~g" \
      | sed 's~onclick="return onDownload(this)"~target="_blank"~g' \
      >> studio/index.html
cat ${BASEDIR}/studio/template.html \
            | sed -n '/<!-- insert -->/,$p' \
            >> studio/index.html
mkdir -p css
cp ${BASEDIR}/css/default.css css/

# clean obsolete studio
if [ -d dl/android/studio ]; then
	valid=`grep -o ${DL_HOST}/dl/android/studio'/[^"]*' studio/index.html.orig | grep -v [.]exe | sed -E 's~'${DL_HOST}'/(dl/android/studio/.+)~\1~g'`
	while read -r file; do
		if ! echo "${valid}" | grep -q ${file}; then
			rm ${file}
		fi
	done <<< "`find dl/android/studio -type f`"
fi

# clean sdk manager
grep -o ${DL_HOST}/${DL_PATH}/'[^"]*' studio/index.html.orig | grep -v [.]exe | sed -E 's~'${DL_HOST}'/~~g' >> ${DL_PATH}/valid
