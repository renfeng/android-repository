#!/bin/bash

# the following script will download 16GB by the date, Feb 8, 2016

# automate the update of studio version, i.e. 1.0.1 at the moment
# TODO clean obsolete sdk manager and studio

# XXX no need to mirror gradle, https://services.gradle.org/distributions/gradle-2.1-bin.zip
# it doesn't download when internet is unavailable, and android studio works just fine

mkdir -p orig/studio
wget http://developer.android.com/studio/index.html -O orig/studio/index.html.tmp

# sed remove lines until
# http://www.linuxquestions.org/questions/linux-newbie-8/how-to-use-sed-to-delete-all-lines-before-the-first-match-of-a-pattern-802069/
# sed remove lines after
# http://stackoverflow.com/questions/5227295/how-do-i-delete-all-lines-in-a-file-starting-from-after-a-matching-line
cat orig/studio/index.html.tmp | sed -n '/<section id="downloads"/,$p' | sed '/section>/q' > orig/studio/index.html
rm orig/studio/index.html.tmp

# download android studio
grep -o 'https://dl.google.com/dl/android/studio/[^"]*' orig/studio/index.html | \
          grep -v [.]exe > dl/android/studio/download.sh.tmp
cat dl/android/studio/download.sh.tmp | \
    sed -E 's/https:(\/\/dl.google.com\/(dl\/android\/studio\/[^\/]+\/[^\/]+)\/.+)/wget -N -P \2 -c http:\1/g' > \
    dl/android/studio/download.sh
rm dl/android/studio/download.sh.tmp
sh dl/android/studio/download.sh

# http://stackoverflow.com/questions/242538/unix-shell-script-find-out-which-directory-the-script-file-resides
BASEDIR=$(dirname $0)

$BASEDIR/sync-index.sh

# http://stackoverflow.com/questions/8535947/xslt-2-0-transformation-via-linux-shell
java -jar $BASEDIR/saxon.jar orig/android/repository/extras/intel/addon.xml \
                         $BASEDIR/android/repository/extras/intel/addon.xsl | \
                       sed 's/https:/http:/g' | \
                       wget -N -P android/repository/extras/intel -c -i -
java -jar $BASEDIR/saxon.jar orig/android/repository/addon-6.xml \
                         $BASEDIR/android/repository/addon-6.xsl | \
                       sed 's/https:/http:/g' | \
                       wget -N -P android/repository -c -i -
java -jar $BASEDIR/saxon.jar orig/android/repository/sys-img/android-tv/sys-img.xml \
                         $BASEDIR/android/repository/sys-img/android-tv/sys-img.xsl | \
                       sed 's/https:/http:/g' | \
                       wget -N -P android/repository/sys-img/android-tv -c -i -
java -jar $BASEDIR/saxon.jar orig/android/repository/repository-11.xml \
                         $BASEDIR/android/repository/repository-11.xsl | \
                       sed 's/https:/http:/g' | \
                       wget -N -P android/repository -c -i -
java -jar $BASEDIR/saxon.jar orig/android/repository/sys-img/android-wear/sys-img.xml \
                         $BASEDIR/android/repository/sys-img/android-wear/sys-img.xsl | \
                       sed 's/https:/http:/g' | \
                       wget -N -P android/repository/sys-img/android-wear -c -i -
java -jar $BASEDIR/saxon.jar orig/android/repository/addon.xml \
                         $BASEDIR/android/repository/addon.xsl | \
                       sed 's/https:/http:/g' | \
                       wget -N -P android/repository -c -i -
java -jar $BASEDIR/saxon.jar orig/android/repository/addon.xml \
                         $BASEDIR/android/repository/addon.admob.xsl | \
                       sed 's/https:/http:/g' | \
                       wget -N -P googleadmobadssdk -c -i -
java -jar $BASEDIR/saxon.jar orig/android/repository/addon.xml \
                         $BASEDIR/android/repository/addon.analytics.xsl | \
                       sed 's/https:/http:/g' | \
                       wget -N -P gaformobileapps -c -i -
java -jar $BASEDIR/saxon.jar orig/android/repository/sys-img/x86/addon-x86.xml \
                         $BASEDIR/android/repository/sys-img/x86/addon-x86.xsl | \
                       sed 's/https:/http:/g' | \
                       wget -N -P android/repository/sys-img/x86 -c -i -
java -jar $BASEDIR/saxon.jar orig/android/repository/sys-img/google_apis/sys-img.xml \
                         $BASEDIR/android/repository/sys-img/google_apis/sys-img.xsl | \
                       sed 's/https:/http:/g' | \
                       wget -N -P android/repository/sys-img/google_apis -c -i -
java -jar $BASEDIR/saxon.jar orig/android/repository/sys-img/android/sys-img.xml \
                         $BASEDIR/android/repository/sys-img/android/sys-img.xsl | \
                       sed 's/https:/http:/g' | \
                       wget -N -P android/repository/sys-img/android -c -i -
java -jar $BASEDIR/saxon.jar orig/glass/gdk/addon.xml \
                         $BASEDIR/glass/gdk/addon.xe22.xsl | \
                       sed 's/https:/http:/g' | \
                       wget -N -P glass/xe22 -c -i -

# make urls relative and local
cat orig/android/repository/addons_list-2.xml | \
    sed 's/https:\/\/dl-ssl.google.com/http:\/\/studyjams.dushu.hu/g' > \
         android/repository/addons_list-2.xml
cat orig/android/repository/extras/intel/addon.xml | \
    sed 's/https:\/\/dl.google.com//g' > \
         android/repository/extras/intel/addon.xml
cat orig/android/repository/addon-6.xml | \
    sed 's/https:\/\/dl.google.com//g' > \
         android/repository/addon-6.xml
cat orig/android/repository/sys-img/android-tv/sys-img.xml | \
    sed 's/https:\/\/dl.google.com//g' > \
         android/repository/sys-img/android-tv/sys-img.xml
cat orig/android/repository/repository-11.xml | \
    sed 's/https:\/\/dl.google.com/http:\/\/studyjams.dushu.hu/g' > \
         android/repository/repository-11.xml
cat orig/android/repository/sys-img/android-wear/sys-img.xml | \
    sed 's/https:\/\/dl.google.com//g' > \
         android/repository/sys-img/android-wear/sys-img.xml
cat orig/android/repository/addon.xml | \
    sed 's/https:\/\/dl.google.com/http:\/\/studyjams.dushu.hu/g' | \
    sed 's/https:\/\/dl.google.com/http:\/\/studyjams.dushu.hu/g' > \
         android/repository/addon.xml
cat orig/android/repository/sys-img/x86/addon-x86.xml | \
    sed 's/https:\/\/dl.google.com//g' > \
         android/repository/sys-img/x86/addon-x86.xml
cat orig/android/repository/sys-img/google_apis/sys-img.xml | \
    sed 's/https:\/\/dl.google.com//g' > \
         android/repository/sys-img/google_apis/sys-img.xml
cat orig/android/repository/sys-img/android/sys-img.xml | \
    sed 's/https:\/\/dl.google.com/http:\/\/studyjams.dushu.hu/g' > \
         android/repository/sys-img/android/sys-img.xml
# glass should be treated as a root path
cat orig/glass/gdk/addon.xml | \
    sed 's/https:\/\/dl.google.com/http:\/\/studyjams.dushu.hu/g' > \
         glass/gdk/addon.xml

# clean obsolete sdk packages
# TODO grep -P is not supported by OS X
$BASEDIR/manage.sh
grep true packages.csv | grep -Po '(?<=https://dl-ssl[.]google[.]com/)[^,]+|(?<=https://dl[.]google[.]com/)[^,]+' | sed -E 's/^(.*)$/rm -f \1/g' > clean-obsolete.sh
sh clean-obsolete.sh

# download sdk manager (requires packages.csv)
grep -o 'dl.google.com/android/[^"]*' orig/studio/index.html | \
    sed -E 's/(.*)/https:\/\/\1/g' | \
    grep -v [.]exe | wget -N -P android -c -i -

mkdir -p studio
cat $BASEDIR/studio/template.html | sed '/<!-- insert -->/q' > studio/index.html
cat orig/studio/index.html | \
    sed 's/https:\/\/dl.google.com//g' | \
    sed 's/http:\/\/dl.google.com//g' | \
    sed 's/onclick="return onDownload(this)"/target="_blank"/g' >> \
         studio/index.html
cat $BASEDIR/studio/template.html | sed -n '/<!-- insert -->/,$p' >> studio/index.html
sed -i 's/\/\/dl.google.com//g' studio/index.html
mkdir -p css
cp $BASEDIR/css/default.css css/

# verify
grep -rn '<sdk:url>' * --include=*.xml --exclude-dir=orig | grep http

# httpd conf
cat $BASEDIR/apache2.conf | sed "s/hu.dushu.studyjams/`pwd | sed 's/\\//\\\\\\//g'`/g" > and-repo.apache2.conf
echo 'include and-repo.apache2.conf in your apache httpd.conf file (or a file included by it, e.g. httpd-vhosts.conf)'
cat and-repo.apache2.conf
