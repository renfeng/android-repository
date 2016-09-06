#!/bin/bash

# http://stackoverflow.com/questions/242538/unix-shell-script-find-out-which-directory-the-script-file-resides
BASEDIR=$(dirname $0)

#$BASEDIR/sync-index.sh

echo "name,version,api-level,revision,description,obsolete,windowsSize,windowsSHA1,windowsURL,macosxSize,macosxSHA1,macosxURL,linuxSize,linuxSHA1,linuxURL" \
	> packages.csv.tmp

# http://stackoverflow.com/questions/8535947/xslt-2-0-transformation-via-linux-shell
xsltproc $BASEDIR/android/repository/extras/intel/addon.csv.xsl \
             orig/android/repository/extras/intel/addon.xml \
	>> packages.csv.tmp
xsltproc $BASEDIR/android/repository/addon-6.csv.xsl \
             orig/android/repository/addon-6.xml \
	>> packages.csv.tmp
xsltproc $BASEDIR/android/repository/sys-img/android-tv/sys-img.csv.xsl \
             orig/android/repository/sys-img/android-tv/sys-img.xml \
	>> packages.csv.tmp
xsltproc $BASEDIR/android/repository/repository-11.csv.xsl \
             orig/android/repository/repository-11.xml \
	>> packages.csv.tmp
xsltproc $BASEDIR/android/repository/sys-img/android-wear/sys-img.csv.xsl \
             orig/android/repository/sys-img/android-wear/sys-img.xml \
	>> packages.csv.tmp
xsltproc $BASEDIR/android/repository/addon.csv.xsl \
             orig/android/repository/addon.xml \
	>> packages.csv.tmp
xsltproc $BASEDIR/android/repository/sys-img/x86/addon-x86.csv.xsl \
             orig/android/repository/sys-img/x86/addon-x86.xml \
	>> packages.csv.tmp
xsltproc $BASEDIR/android/repository/sys-img/google_apis/sys-img.csv.xsl \
             orig/android/repository/sys-img/google_apis/sys-img.xml \
	>> packages.csv.tmp
xsltproc $BASEDIR/android/repository/sys-img/android/sys-img.csv.xsl \
             orig/android/repository/sys-img/android/sys-img.xml \
	>> packages.csv.tmp
xsltproc $BASEDIR/glass/gdk/addon.xe22.csv.xsl \
             orig/glass/gdk/addon.xml \
	>> packages.csv.tmp

mv packages.csv.tmp packages.csv
