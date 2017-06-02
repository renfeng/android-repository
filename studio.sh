#!/bin/bash

# TODO automate the update of studio version, e.g. 2.2.3.0 as of 2017-01-15
# TODO clean obsolete sdk manager and studio

# http://stackoverflow.com/questions/242538/unix-shell-script-find-out-which-directory-the-script-file-resides
BASEDIR=$(dirname $0)

DL_HOST=${DL_HOST:-https://dl.google.com}
DL_PATH=${DL_PATH:-android/repository}

mkdir -p orig/studio
wget --no-check-certificate https://developer.android.com/studio/index.html -O orig/studio/index.html.tmp

#mkdir -p dl/android/studio/ide-zips/1.0.1
#mkdir -p dl/android/studio/install/1.0.1
mkdir -p dl/android/studio

# download android studio
grep -o ${DL_HOST}/dl/android/studio'/[^"]*' orig/studio/index.html.tmp \
            | grep -v [.]exe > dl/android/studio/download.sh.tmp
cat dl/android/studio/download.sh.tmp \
  | sed -E 's~('${DL_HOST}'/('dl/android/studio'/[^/]+/[^/]+)/.+)~wget -N -P \2 -c \1~g' \
  > dl/android/studio/download.sh
rm dl/android/studio/download.sh.tmp
sh dl/android/studio/download.sh

# download sdk manager
grep -o ${DL_HOST}/${DL_PATH}/'[^"]*' orig/studio/index.html.tmp \
    | grep -v [.]exe \
    | wget -N -P ${DL_PATH} -c -i -

# generate download page
# sed remove lines until
# http://www.linuxquestions.org/questions/linux-newbie-8/how-to-use-sed-to-delete-all-lines-before-the-first-match-of-a-pattern-802069/
# sed remove lines after
# http://stackoverflow.com/questions/5227295/how-do-i-delete-all-lines-in-a-file-starting-from-after-a-matching-line
cat orig/studio/index.html.tmp \
  | sed -n '/<section id="downloads"/,$p' \
  | sed '/section>/q' \
  > orig/studio/index.html
cat orig/studio/index.html.tmp \
  | sed -n '/<section id="Requirements"/,$p' \
  | sed '/section>/q' \
  >> orig/studio/index.html
rm orig/studio/index.html.tmp

mkdir -p studio
cat ${BASEDIR}/studio/template.html \
             | sed '/<!-- insert -->/q' \
             > studio/index.html
cat orig/studio/index.html \
      | sed "s~${DL_HOST}~~g" \
      | sed 's~onclick="return onDownload(this)"~target="_blank"~g' \
      >> studio/index.html
cat ${BASEDIR}/studio/template.html \
            | sed -n '/<!-- insert -->/,$p' \
            >> studio/index.html
sed -i 's~//dl.google.com~~g' studio/index.html
mkdir -p css
cp ${BASEDIR}/css/default.css css/
