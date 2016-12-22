#!/bin/bash

# the following script downloads 16GB as of Feb 8, 2016

# automate the update of studio version, i.e. 1.0.1 at the moment
# TODO clean obsolete sdk manager and studio

# no need to mirror gradle, https://services.gradle.org/distributions/gradle-2.1-bin.zip
# it doesn't download when internet is unavailable, and android studio works just fine

# http://stackoverflow.com/questions/242538/unix-shell-script-find-out-which-directory-the-script-file-resides
BASEDIR=$(dirname $0)

${BASEDIR}/sync-index.sh

# http://www.sagehill.net/docbookxsl/InstallingAProcessor.html#cygwin
xsltproc ${BASEDIR}/android/repository/extras/intel/addon.xsl \
               orig/android/repository/extras/intel/addon.xml \
       | sed 's/https:/http:/g' \
       | wget -N -P android/repository/extras/intel -c -i -
xsltproc ${BASEDIR}/android/repository/addon-6.xsl \
               orig/android/repository/addon-6.xml \
       | sed 's/https:/http:/g' \
       | wget -N -P android/repository -c -i -
xsltproc ${BASEDIR}/android/repository/sys-img/android-tv/sys-img.xsl \
               orig/android/repository/sys-img/android-tv/sys-img.xml \
       | sed 's/https:/http:/g' \
       | wget -N -P android/repository/sys-img/android-tv -c -i -
xsltproc ${BASEDIR}/android/repository/repository-11.xsl \
               orig/android/repository/repository-11.xml \
       | sed 's/https:/http:/g' \
       | wget -N -P android/repository -c -i -
xsltproc ${BASEDIR}/android/repository/sys-img/android-wear/sys-img.xsl \
               orig/android/repository/sys-img/android-wear/sys-img.xml \
       | sed 's/https:/http:/g' \
       | wget -N -P android/repository/sys-img/android-wear -c -i -
xsltproc ${BASEDIR}/android/repository/addon.xsl \
               orig/android/repository/addon.xml \
       | sed 's/https:/http:/g' \
       | wget -N -P android/repository -c -i -
xsltproc ${BASEDIR}/android/repository/addon.admob.xsl \
               orig/android/repository/addon.xml \
       | sed 's/https:/http:/g' \
       | wget -N -P googleadmobadssdk -c -i -
xsltproc ${BASEDIR}/android/repository/addon.analytics.xsl \
               orig/android/repository/addon.xml \
       | sed 's/https:/http:/g' \
       | wget -N -P gaformobileapps -c -i -
xsltproc ${BASEDIR}/android/repository/sys-img/x86/addon-x86.xsl \
               orig/android/repository/sys-img/x86/addon-x86.xml \
       | sed 's/https:/http:/g' \
       | wget -N -P android/repository/sys-img/x86 -c -i -
xsltproc ${BASEDIR}/android/repository/sys-img/google_apis/sys-img.xsl \
               orig/android/repository/sys-img/google_apis/sys-img.xml \
       | sed 's/https:/http:/g' \
       | wget -N -P android/repository/sys-img/google_apis -c -i -
xsltproc ${BASEDIR}/android/repository/sys-img/android/sys-img.xsl \
               orig/android/repository/sys-img/android/sys-img.xml \
       | sed 's/https:/http:/g' \
       | wget -N -P android/repository/sys-img/android -c -i -
xsltproc ${BASEDIR}/glass/gdk/addon.xe22.xsl \
               orig/glass/gdk/addon.xml \
       | sed 's/https:/http:/g' \
       | wget -N -P glass/xe22 -c -i -

# make urls relative and local
cat orig/android/repository/addons_list-2.xml \
       | sed 's/https:\/\/dl-ssl.google.com/http:\/\/studyjams.dushu.hu/g' \
       > android/repository/addons_list-2.xml
cat orig/android/repository/extras/intel/addon.xml \
       | sed 's/https:\/\/dl.google.com//g' \
       > android/repository/extras/intel/addon.xml
cat orig/android/repository/addon-6.xml \
       | sed 's/https:\/\/dl.google.com//g' \
       > android/repository/addon-6.xml
cat orig/android/repository/sys-img/android-tv/sys-img.xml \
       | sed 's/https:\/\/dl.google.com//g' \
       > android/repository/sys-img/android-tv/sys-img.xml
cat orig/android/repository/repository-11.xml \
       | sed 's/https:\/\/dl.google.com/http:\/\/studyjams.dushu.hu/g' \
       > android/repository/repository-11.xml
cat orig/android/repository/sys-img/android-wear/sys-img.xml \
       | sed 's/https:\/\/dl.google.com//g' \
       > android/repository/sys-img/android-wear/sys-img.xml
cat orig/android/repository/addon.xml \
       | sed 's/https:\/\/dl.google.com/http:\/\/studyjams.dushu.hu/g' \
       | sed 's/https:\/\/dl.google.com/http:\/\/studyjams.dushu.hu/g' \
       > android/repository/addon.xml
cat orig/android/repository/sys-img/x86/addon-x86.xml \
       | sed 's/https:\/\/dl.google.com//g' \
       > android/repository/sys-img/x86/addon-x86.xml
cat orig/android/repository/sys-img/google_apis/sys-img.xml \
       | sed 's/https:\/\/dl.google.com//g' \
       > android/repository/sys-img/google_apis/sys-img.xml
cat orig/android/repository/sys-img/android/sys-img.xml \
       | sed 's/https:\/\/dl.google.com/http:\/\/studyjams.dushu.hu/g' \
       > android/repository/sys-img/android/sys-img.xml
# glass should be treated as a root path
cat orig/glass/gdk/addon.xml \
       | sed 's/https:\/\/dl.google.com/http:\/\/studyjams.dushu.hu/g' \
       > glass/gdk/addon.xml

# sdk web manager (generates packages.csv)
${BASEDIR}/manage.sh

# clean obsolete sdk packages (requires packages.csv)
# TODO grep -P is not supported by OS X
grep true packages.csv \
    | grep -Po '(?<=https://dl-ssl[.]google[.]com/)[^,]+|(?<=https://dl[.]google[.]com/)[^,]+' \
    | sed -E 's/^(.*)$/rm -f \1/g' \
    > clean-obsolete.sh
sh clean-obsolete.sh

# verify (list urls not localized)
grep -rn '<sdk:url>' * --include=*.xml --exclude-dir=orig \
    | grep http

mkdir -p orig/studio
wget http://developer.android.com/studio/index.html -O orig/studio/index.html.tmp

# download android studio
grep -o 'https://dl.google.com/dl/android/studio/[^"]*' orig/studio/index.html.tmp \
            | grep -v [.]exe > dl/android/studio/download.sh.tmp
cat dl/android/studio/download.sh.tmp \
  | sed -E 's/https:(\/\/dl.google.com\/(dl\/android\/studio\/[^\/]+\/[^\/]+)\/.+)/wget -N -P \2 -c http:\1/g' \
  > dl/android/studio/download.sh
rm dl/android/studio/download.sh.tmp
sh dl/android/studio/download.sh

# download sdk manager
grep -o '//dl.google.com/android/[^"]*' orig/studio/index.html \
    | sed -E 's/(.*)/https:\1/g' \
    | grep -v [.]exe \
    | wget -N -P android -c -i -

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
      | sed 's/https:\/\/dl.google.com//g' \
      | sed 's/http:\/\/dl.google.com//g' \
      | sed 's/onclick="return onDownload(this)"/target="_blank"/g' \
      >> studio/index.html
cat ${BASEDIR}/studio/template.html \
            | sed -n '/<!-- insert -->/,$p' \
            >> studio/index.html
sed -i 's/\/\/dl.google.com//g' studio/index.html
mkdir -p css
cp ${BASEDIR}/css/default.css css/

# httpd conf
cat ${BASEDIR}/apache2.conf | sed "s/hu.dushu.studyjams/`pwd | sed 's/\\//\\\\\\//g'`/g" > and-repo.apache2.conf
echo 'include and-repo.apache2.conf in your apache httpd.conf file (or a file included by it, e.g. httpd-vhosts.conf)'
cat and-repo.apache2.conf
