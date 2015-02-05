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
mkdir -p sdk

# http://stackoverflow.com/questions/4944295/wget-skip-if-files-exist/16840827#16840827
# http://www.gnu.org/software/wget/manual/wget.html
wget https://dl-ssl.google.com/android/repository/addons_list-2.xml -O android/repository/addons_list-2.xml.orig
wget https://dl-ssl.google.com/android/repository/extras/intel/addon.xml -O android/repository/extras/intel/addon.xml.orig
wget https://dl-ssl.google.com/android/repository/addon-6.xml -O android/repository/addon-6.xml.orig
wget https://dl-ssl.google.com/android/repository/sys-img/android-tv/sys-img.xml -O android/repository/sys-img/android-tv/sys-img.xml.orig
wget https://dl-ssl.google.com/android/repository/repository-10.xml -O android/repository/repository-10.xml.orig
wget https://dl-ssl.google.com/android/repository/sys-img/android-wear/sys-img.xml -O android/repository/sys-img/android-wear/sys-img.xml.orig
wget https://dl-ssl.google.com/android/repository/addon.xml -O android/repository/addon.xml.orig
wget https://dl-ssl.google.com/android/repository/sys-img/x86/addon-x86.xml -O android/repository/sys-img/x86/addon-x86.xml.orig
wget https://dl-ssl.google.com/android/repository/sys-img/google_apis/sys-img.xml -O android/repository/sys-img/google_apis/sys-img.xml.orig
wget https://dl-ssl.google.com/android/repository/sys-img/android/sys-img.xml -O android/repository/sys-img/android/sys-img.xml.orig
wget https://dl-ssl.google.com/glass/gdk/addon.xml -O glass/gdk/addon.xml.orig
wget https://developer.android.com/sdk/index.html -O sdk/index.html.orig

# http://stackoverflow.com/questions/8535947/xslt-2-0-transformation-via-linux-shell
java -jar $BASEDIR/saxon.jar android/repository/extras/intel/addon.xml.orig $BASEDIR/android/repository/extras/intel/addon.xsl | wget -N -P android/repository/extras/intel -c -i -
java -jar $BASEDIR/saxon.jar android/repository/addon-6.xml.orig $BASEDIR/android/repository/addon-6.xsl | wget -N -P android/repository -c -i -
java -jar $BASEDIR/saxon.jar android/repository/sys-img/android-tv/sys-img.xml.orig $BASEDIR/android/repository/sys-img/android-tv/sys-img.xsl | wget -N -P android/repository/sys-img/android-tv -c -i -
# requires 4GB
java -jar $BASEDIR/saxon.jar android/repository/repository-10.xml.orig $BASEDIR/android/repository/repository-10.xsl | wget -N -P android/repository -c -i -
java -jar $BASEDIR/saxon.jar android/repository/sys-img/android-wear/sys-img.xml.orig $BASEDIR/android/repository/sys-img/android-wear/sys-img.xsl | wget -N -P android/repository/sys-img/android-wear -c -i -
java -jar $BASEDIR/saxon.jar android/repository/addon.xml.orig $BASEDIR/android/repository/addon.xsl | wget -N -P android/repository -c -i -
java -jar $BASEDIR/saxon.jar android/repository/addon.xml.orig $BASEDIR/android/repository/addon.admob.xsl | wget -N -P googleadmobadssdk -c -i -
java -jar $BASEDIR/saxon.jar android/repository/addon.xml.orig $BASEDIR/android/repository/addon.analytics.xsl | wget -N -P gaformobileapps -c -i -
java -jar $BASEDIR/saxon.jar android/repository/sys-img/x86/addon-x86.xml.orig $BASEDIR/android/repository/sys-img/x86/addon.xsl | wget -N -P android/repository/sys-img/x86 -c -i -
java -jar $BASEDIR/saxon.jar android/repository/sys-img/google_apis/sys-img.xml.orig $BASEDIR/android/repository/sys-img/google_apis/sys-img.xsl | wget -N -P android/repository/sys-img/google_apis -c -i -
java -jar $BASEDIR/saxon.jar android/repository/sys-img/android/sys-img.xml.orig $BASEDIR/android/repository/sys-img/android/sys-img.xsl | wget -N -P android/repository/sys-img/android -c -i -
java -jar $BASEDIR/saxon.jar glass/gdk/addon.xml.orig $BASEDIR/glass/gdk/addon.xe22.xsl | wget -N -P glass/xe22 -c -i -

# sed remove lines until
# http://www.linuxquestions.org/questions/linux-newbie-8/how-to-use-sed-to-delete-all-lines-before-the-first-match-of-a-pattern-802069/
# sed remove lines after
# http://stackoverflow.com/questions/5227295/how-do-i-delete-all-lines-in-a-file-starting-from-after-a-matching-line
sed -n '/pax/,$p' -i sdk/index.html.orig
sed '/end pax/q' -i sdk/index.html.orig

grep -Po 'https://dl.google.com/dl/android/studio/install/1.0.1/[^"]*' sdk/index.html.orig | wget -N -P dl/android/studio/install/1.0.1 -c -i -
grep -Po 'https://dl.google.com/dl/android/studio/ide-zips/1.0.1/[^"]*' sdk/index.html.orig | wget -N -P dl/android/studio/ide-zips/1.0.1 -c -i -
grep -Po 'http://dl.google.com/android/[^"]*' sdk/index.html.orig | wget -N -P android -c -i -

sed '/<!-- insert -->/q' sdk/template.html > sdk/index.html.tmp
cat sdk/index.html.orig | sed 's/https:\/\/dl.google.com//g' | sed 's/http:\/\/dl.google.com//g' | sed 's/onclick="return onDownload(this)"/target="_blank"/g' >> sdk/index.html.tmp
sed -n '/<!-- insert -->/,$p' sdk/template.html >> sdk/index.html.tmp
mv sdk/index.html.tmp sdk/index.html

# make urls relative and local
sed 's/https:\/\/dl-ssl.google.com//g' android/repository/addons_list-2.xml.orig > android/repository/addons_list-2.xml
sed 's/https:\/\/dl-ssl.google.com//g' android/repository/extras/intel/addon.xml.orig > android/repository/extras/intel/addon.xml
sed 's/https:\/\/dl-ssl.google.com//g' android/repository/addon-6.xml.orig > android/repository/addon-6.xml
sed 's/https:\/\/dl-ssl.google.com//g' android/repository/sys-img/android-tv/sys-img.xml.orig > android/repository/sys-img/android-tv/sys-img.xml
sed 's/https:\/\/dl-ssl.google.com//g' android/repository/repository-10.xml.orig > android/repository/repository-10.xml
sed 's/https:\/\/dl-ssl.google.com//g' android/repository/sys-img/android-wear/sys-img.xml.orig > android/repository/sys-img/android-wear/sys-img.xml
cat android/repository/addon.xml.orig | sed 's/https:\/\/dl-ssl.google.com//g' | sed 's/https:\/\/dl.google.com//g' > android/repository/addon.xml
sed 's/https:\/\/dl-ssl.google.com//g' android/repository/sys-img/x86/addon-x86.xml.orig > android/repository/sys-img/x86/addon-x86.xml
sed 's/https:\/\/dl-ssl.google.com//g' android/repository/sys-img/google_apis/sys-img.xml.orig > android/repository/sys-img/google_apis/sys-img.xml
sed 's/https:\/\/dl-ssl.google.com//g' android/repository/sys-img/android/sys-img.xml.orig > android/repository/sys-img/android/sys-img.xml
sed 's/https:\/\/dl.google.com//g' glass/gdk/addon.xml.orig > glass/gdk/addon.xml

# verify
grep -Prn '<sdk:url>' * --include=*.xml --exclude=*.orig | grep http
