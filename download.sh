#!/bin/bash

# http://stackoverflow.com/questions/242538/unix-shell-script-find-out-which-directory-the-script-file-resides
BASEDIR=$(dirname $0)

# http://www.gnu.org/savannah-checkouts/gnu/grep/manual/grep.html
#grep -Po '(?<=@name@).*/android/repository/.*(?==)' ~/.android/sites-settings.cfg | sed 's/\\//g' | wget -N -c -i -
grep -Po '(?<=@name@).*/android/repository/.*(?==)' ~/.android/sites-settings.cfg | sed 's/\\//g'

# https://dl-ssl.google.com/android/repository/extras/intel/addon.xml
# https://dl-ssl.google.com/android/repository/addon-6.xml
# https://dl-ssl.google.com/android/repository/sys-img/android-tv/sys-img.xml
# https://dl-ssl.google.com/android/repository/repository-10.xml
# https://dl-ssl.google.com/android/repository/sys-img/android-wear/sys-img.xml
# https://dl-ssl.google.com/android/repository/addon.xml
# https://dl-ssl.google.com/android/repository/sys-img/x86/addon-x86.xml
# https://dl-ssl.google.com/android/repository/sys-img/google_apis/sys-img.xml
# https://dl-ssl.google.com/android/repository/sys-img/android/sys-img.xml
# https://dl-ssl.google.com/glass/gdk/addon.xml

mkdir -p android/repository/extras/intel
mkdir -p android/repository/sys-img/android-tv
mkdir -p android/repository/sys-img/android-wear
mkdir -p android/repository/sys-img/x86
mkdir -p android/repository/sys-img/google_apis
mkdir -p android/repository/sys-img/android
mkdir -p glass/xe22
mkdir -p googleadmobadssdk
mkdir -p gaformobileapps
mkdir -p dl/android/studio/ide-zips/1.0.1
mkdir -p dl/android/studio/install/1.0.1

# http://stackoverflow.com/questions/4944295/wget-skip-if-files-exist/16840827#16840827
# http://www.gnu.org/software/wget/manual/wget.html
wget -N https://dl-ssl.google.com/android/repository/addons_list-2.xml -P android/repository
wget -N https://dl-ssl.google.com/android/repository/extras/intel/addon.xml -P android/repository/extras/intel
wget -N https://dl-ssl.google.com/android/repository/addon-6.xml -P android/repository
wget -N https://dl-ssl.google.com/android/repository/sys-img/android-tv/sys-img.xml -P android/repository/sys-img/android-tv
wget -N https://dl-ssl.google.com/android/repository/repository-10.xml -P android/repository
wget -N https://dl-ssl.google.com/android/repository/sys-img/android-wear/sys-img.xml -P android/repository/sys-img/android-wear
wget -N https://dl-ssl.google.com/android/repository/addon.xml -P android/repository
wget -N https://dl-ssl.google.com/android/repository/sys-img/x86/addon-x86.xml -P android/repository/sys-img/x86
wget -N https://dl-ssl.google.com/android/repository/sys-img/google_apis/sys-img.xml -P android/repository/sys-img/google_apis
wget -N https://dl-ssl.google.com/android/repository/sys-img/android/sys-img.xml -P android/repository/sys-img/android
wget -N https://dl-ssl.google.com/glass/gdk/addon.xml -P glass/gdk
wget -N https://developer.android.com/sdk/index.html -P dl/android

# http://stackoverflow.com/questions/8535947/xslt-2-0-transformation-via-linux-shell
java -jar $BASEDIR/saxon.jar android/repository/extras/intel/addon.xml $BASEDIR/android/repository/extras/intel/addon.xsl | wget -N -P android/repository/extras/intel -c -i -
java -jar $BASEDIR/saxon.jar android/repository/addon-6.xml $BASEDIR/android/repository/addon-6.xsl | wget -N -P android/repository -c -i -
java -jar $BASEDIR/saxon.jar android/repository/sys-img/android-tv/sys-img.xml $BASEDIR/android/repository/sys-img/android-tv/sys-img.xsl | wget -N -P android/repository/sys-img/android-tv -c -i -
# requires 4GB
java -jar $BASEDIR/saxon.jar android/repository/repository-10.xml $BASEDIR/android/repository/repository-10.xsl | wget -N -P android/repository -c -i -
java -jar $BASEDIR/saxon.jar android/repository/sys-img/android-wear/sys-img.xml $BASEDIR/android/repository/sys-img/android-wear/sys-img.xsl | wget -N -P android/repository/sys-img/android-wear -c -i -
java -jar $BASEDIR/saxon.jar android/repository/addon.xml $BASEDIR/android/repository/addon.xsl | wget -N -P android/repository -c -i -
java -jar $BASEDIR/saxon.jar android/repository/addon.xml $BASEDIR/android/repository/addon.admob.xsl | wget -N -P googleadmobadssdk -c -i -
java -jar $BASEDIR/saxon.jar android/repository/addon.xml $BASEDIR/android/repository/addon.analytics.xsl | wget -N -P gaformobileapps -c -i -
java -jar $BASEDIR/saxon.jar android/repository/sys-img/x86/addon-x86.xml $BASEDIR/android/repository/sys-img/x86/addon.xsl | wget -N -P android/repository/sys-img/x86 -c -i -
java -jar $BASEDIR/saxon.jar android/repository/sys-img/google_apis/sys-img.xml $BASEDIR/android/repository/sys-img/google_apis/sys-img.xsl | wget -N -P android/repository/sys-img/google_apis -c -i -
java -jar $BASEDIR/saxon.jar android/repository/sys-img/android/sys-img.xml $BASEDIR/android/repository/sys-img/android/sys-img.xsl | wget -N -P android/repository/sys-img/android -c -i -
java -jar $BASEDIR/saxon.jar glass/gdk/addon.xml $BASEDIR/glass/gdk/addon.xe22.xsl | wget -N -P glass/xe22 -c -i -

# sed remove lines until
# http://www.linuxquestions.org/questions/linux-newbie-8/how-to-use-sed-to-delete-all-lines-before-the-first-match-of-a-pattern-802069/
# sed remove lines after
# http://stackoverflow.com/questions/5227295/how-do-i-delete-all-lines-in-a-file-starting-from-after-a-matching-line
cp dl/android/index.html dl/android/index.html.orig
sed -n '/pax/,$p' -i dl/android/index.html
sed '/end pax/q' -i dl/android/index.html
grep -Po 'https://dl.google.com/dl/android/studio/install/1.0.1/[^"]*' dl/android/index.html | wget -N -P dl/android/studio/install/1.0.1 -c -i -
grep -Po 'https://dl.google.com/dl/android/studio/ide-zips/1.0.1/[^"]*' dl/android/index.html | wget -N -P dl/android/studio/ide-zips/1.0.1 -c -i -
grep -Po 'http://dl.google.com/android/[^"]*' dl/android/index.html | wget -N -P android -c -i -
sed -i 's/https:\/\/dl.google.com//g' dl/android/index.html
sed -i 's/http:\/\/dl.google.com//g' dl/android/index.html
sed -i 's/onclick="return onDownload(this)"/target="_blank"/g' dl/android/index.html
sed '/<!-- insert -->/q' dl/android/template.html > dl/android/index.html.tmp
cat dl/android/index.html >> dl/android/index.html.tmp
sed -n '/<!-- insert -->/,$p' dl/android/template.html >> dl/android/index.html.tmp
mv dl/android/index.html.tmp dl/android/index.html

# make urls relative and local
cp android/repository/addons_list-2.xml android/repository/addons_list-2.xml.orig
sed -i 's/https:\/\/dl-ssl.google.com//g' android/repository/addons_list-2.xml

cp android/repository/extras/intel/addon.xml android/repository/extras/intel/addon.xml.orig
sed -i 's/https:\/\/dl-ssl.google.com//g' android/repository/extras/intel/addon.xml

cp android/repository/addon-6.xml android/repository/addon-6.xml.orig
sed -i 's/https:\/\/dl-ssl.google.com//g' android/repository/addon-6.xml

cp android/repository/sys-img/android-tv/sys-img.xml android/repository/sys-img/android-tv/sys-img.xml.orig
sed-i 's/https:\/\/dl-ssl.google.com//g' android/repository/sys-img/android-tv/sys-img.xml

cp android/repository/repository-10.xml android/repository/repository-10.xml.orig
sed -i 's/https:\/\/dl-ssl.google.com//g' android/repository/repository-10.xml

cp android/repository/sys-img/android-wear/sys-img.xml android/repository/sys-img/android-wear/sys-img.xml.orig
sed -i 's/https:\/\/dl-ssl.google.com//g' android/repository/sys-img/android-wear/sys-img.xml

cp android/repository/addon.xml android/repository/addon.xml.orig
sed -i 's/https:\/\/dl-ssl.google.com//g' android/repository/addon.xml
sed -i 's/https:\/\/dl.google.com//g' android/repository/addon.xml

cp android/repository/sys-img/x86/addon-x86.xml android/repository/sys-img/x86/addon-x86.xml.orig
sed -i 's/https:\/\/dl-ssl.google.com//g' android/repository/sys-img/x86/addon-x86.xml

cp android/repository/sys-img/google_apis/sys-img.xml android/repository/sys-img/google_apis/sys-img.xml.orig
sed -i 's/https:\/\/dl-ssl.google.com//g' android/repository/sys-img/google_apis/sys-img.xml

cp android/repository/sys-img/android/sys-img.xml android/repository/sys-img/android/sys-img.xml.orig
sed -i 's/https:\/\/dl-ssl.google.com//g' android/repository/sys-img/android/sys-img.xml

cp glass/gdk/addon.xml glass/gdk/addon.xml.orig
sed -i 's/https:\/\/dl.google.com//g' glass/gdk/addon.xml

# verify
grep -Prn '<sdk:url>' * --include=*.xml --exclude=*.orig | grep http
