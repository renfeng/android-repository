#!/bin/bash

BASEDIR=$(dirname $0)

# http://www.gnu.org/savannah-checkouts/gnu/grep/manual/grep.html
#grep -Po '(?<=@name@).*/android/repository/.*(?==)' ~/.android/sites-settings.cfg | sed 's/\\//g' | wget -N -i -
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

# http://stackoverflow.com/questions/4944295/wget-skip-if-files-exist/16840827#16840827
# http://www.gnu.org/software/wget/manual/wget.html
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

# http://stackoverflow.com/questions/8535947/xslt-2-0-transformation-via-linux-shell
java -jar /usr/share/java/saxon.jar android/repository/extras/intel/addon.xml $BASEDIR/android/repository/extras/intel/addon.xsl | wget -N -P android/repository/extras/intel -i -
java -jar /usr/share/java/saxon.jar android/repository/addon-6.xml $BASEDIR/android/repository/addon-6.xsl | wget -N -P android/repository -i -
java -jar /usr/share/java/saxon.jar android/repository/sys-img/android-tv/sys-img.xml $BASEDIR/android/repository/sys-img/android-tv/sys-img.xsl | wget -N -P android/repository/sys-img/android-tv -i -
# requires 4GB
java -jar /usr/share/java/saxon.jar android/repository/repository-10.xml $BASEDIR/android/repository/repository-10.xsl | wget -N -P android/repository -i -
java -jar /usr/share/java/saxon.jar android/repository/sys-img/android-wear/sys-img.xml $BASEDIR/android/repository/sys-img/android-wear/sys-img.xsl | wget -N -P android/repository/sys-img/android-wear -i -
java -jar /usr/share/java/saxon.jar android/repository/addon.xml $BASEDIR/android/repository/addon.xsl | wget -N -P android/repository -i -
java -jar /usr/share/java/saxon.jar android/repository/addon.xml $BASEDIR/android/repository/addon.admob.xsl | wget -N -P googleadmobadssdk -i -
java -jar /usr/share/java/saxon.jar android/repository/addon.xml $BASEDIR/android/repository/addon.analytics.xsl | wget -N -P gaformobileapps -i -
java -jar /usr/share/java/saxon.jar android/repository/sys-img/x86/addon-x86.xml $BASEDIR/android/repository/sys-img/x86/addon.xsl | wget -N -P android/repository/sys-img/x86 -i -
java -jar /usr/share/java/saxon.jar android/repository/sys-img/google_apis/sys-img.xml $BASEDIR/android/repository/sys-img/google_apis/sys-img.xsl | wget -N -P android/repository/sys-img/google_apis -i -
java -jar /usr/share/java/saxon.jar android/repository/sys-img/android/sys-img.xml $BASEDIR/android/repository/sys-img/android/sys-img.xsl | wget -N -P android/repository/sys-img/android -i -
java -jar /usr/share/java/saxon.jar glass/gdk/addon.xml $BASEDIR/glass/gdk/addon.xe22.xsl | wget -N -P glass/xe22 -i -

# make urls relative and local
cp android/repository/extras/intel/addon.xml android/repository/extras/intel/addon.xml.orig
sed -i 's/https:\/\/dl-ssl.google.com//g' android/repository/extras/intel/addon.xml

cp android/repository/addon-6.xml android/repository/addon-6.xml.orig
sed -i 's/https:\/\/dl-ssl.google.com//g' android/repository/addon-6.xml

cp android/repository/sys-img/android-tv/sys-img.xml android/repository/sys-img/android-tv/sys-img.xml.orig
sed -i 's/https:\/\/dl-ssl.google.com//g' android/repository/sys-img/android-tv/sys-img.xml

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
