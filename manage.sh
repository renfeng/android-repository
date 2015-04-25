#!/bin/bash

# http://stackoverflow.com/questions/242538/unix-shell-script-find-out-which-directory-the-script-file-resides
BASEDIR=$(dirname $0)

$BASEDIR/sync-index.sh

echo "name,version,api-level,revision,description,obsolete,windowsSize,windowsSHA1,windowsURL,macosxSize,macosxSHA1,macosxURL,linuxSize,linuxSHA1,linuxURL" \
	> packages.csv.tmp

# http://stackoverflow.com/questions/8535947/xslt-2-0-transformation-via-linux-shell
java -jar $BASEDIR/saxon.jar orig/android/repository/extras/intel/addon.xml \
                         $BASEDIR/android/repository/extras/intel/addon.csv.xsl \
	>> packages.csv.tmp
java -jar $BASEDIR/saxon.jar orig/android/repository/addon-6.xml \
                         $BASEDIR/android/repository/addon-6.csv.xsl \
	>> packages.csv.tmp
java -jar $BASEDIR/saxon.jar orig/android/repository/sys-img/android-tv/sys-img.xml \
                         $BASEDIR/android/repository/sys-img/android-tv/sys-img.csv.xsl \
	>> packages.csv.tmp
java -jar $BASEDIR/saxon.jar orig/android/repository/repository-10.xml \
                         $BASEDIR/android/repository/repository-10.csv.xsl \
	>> packages.csv.tmp
java -jar $BASEDIR/saxon.jar orig/android/repository/sys-img/android-wear/sys-img.xml \
                         $BASEDIR/android/repository/sys-img/android-wear/sys-img.csv.xsl \
	>> packages.csv.tmp
java -jar $BASEDIR/saxon.jar orig/android/repository/addon.xml \
                         $BASEDIR/android/repository/addon.csv.xsl \
	>> packages.csv.tmp
java -jar $BASEDIR/saxon.jar orig/android/repository/sys-img/x86/addon-x86.xml \
                         $BASEDIR/android/repository/sys-img/x86/addon-x86.csv.xsl \
	>> packages.csv.tmp
java -jar $BASEDIR/saxon.jar orig/android/repository/sys-img/google_apis/sys-img.xml \
                         $BASEDIR/android/repository/sys-img/google_apis/sys-img.csv.xsl \
	>> packages.csv.tmp
java -jar $BASEDIR/saxon.jar orig/android/repository/sys-img/android/sys-img.xml \
                         $BASEDIR/android/repository/sys-img/android/sys-img.csv.xsl \
	>> packages.csv.tmp
java -jar $BASEDIR/saxon.jar orig/glass/gdk/addon.xml \
                         $BASEDIR/glass/gdk/addon.xe22.csv.xsl \
	>> packages.csv.tmp

mv packages.csv.tmp packages.csv
