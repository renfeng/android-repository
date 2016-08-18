#!/bin/bash

# http://www.gnu.org/savannah-checkouts/gnu/grep/manual/grep.html
#grep -Po '(?<=@name@).*/android/repository/.*(?==)' ~/.android/sites-settings.cfg | sed 's/\\//g' | wget -N -c -i -
#grep -Po '(?<=@name@).*/android/repository/.*(?==)' ~/.android/sites-settings.cfg | sed 's/\\//g'

# https://dl-ssl.google.com/android/repository/extras/intel/addon.xml
# https://dl-ssl.google.com/android/repository/addon-6.xml
# https://dl-ssl.google.com/android/repository/sys-img/android-tv/sys-img.xml
# https://dl-ssl.google.com/android/repository/repository-11.xml
# https://dl-ssl.google.com/android/repository/sys-img/android-wear/sys-img.xml
# https://dl-ssl.google.com/android/repository/addon.xml
# https://dl-ssl.google.com/android/repository/sys-img/x86/addon-x86.xml
# https://dl-ssl.google.com/android/repository/sys-img/google_apis/sys-img.xml
# https://dl-ssl.google.com/android/repository/sys-img/android/sys-img.xml
# https://dl-ssl.google.com/glass/gdk/addon.xml

#mkdir -p android/repository/extras/intel
#mkdir -p android/repository/sys-img/android-tv
#mkdir -p android/repository/sys-img/android-wear
mkdir -p android/repository/sys-img/x86
#mkdir -p android/repository/sys-img/google_apis
#mkdir -p android/repository/sys-img/android
mkdir -p glass/gdk
#mkdir -p glass/xe22
#mkdir -p googleadmobadssdk
#mkdir -p gaformobileapps
#mkdir -p dl/android/studio/ide-zips/1.0.1
#mkdir -p dl/android/studio/install/1.0.1
mkdir -p dl/android/studio
#mkdir -p sdk

# http://stackoverflow.com/questions/4944295/wget-skip-if-files-exist/16840827#16840827
# http://www.gnu.org/software/wget/manual/wget.html
wget -N http://dl-ssl.google.com/android/repository/addons_list-2.xml \
                         -P orig/android/repository
wget -N http://dl-ssl.google.com/android/repository/extras/intel/addon.xml \
                         -P orig/android/repository/extras/intel
wget -N http://dl-ssl.google.com/android/repository/addon-6.xml \
                         -P orig/android/repository
wget -N http://dl-ssl.google.com/android/repository/sys-img/android-tv/sys-img.xml \
                         -P orig/android/repository/sys-img/android-tv
wget -N http://dl-ssl.google.com/android/repository/repository-11.xml \
                         -P orig/android/repository
wget -N http://dl-ssl.google.com/android/repository/sys-img/android-wear/sys-img.xml \
                         -P orig/android/repository/sys-img/android-wear
wget -N http://dl-ssl.google.com/android/repository/addon.xml \
                         -P orig/android/repository
wget -N http://dl-ssl.google.com/android/repository/sys-img/x86/addon-x86.xml \
                         -P orig/android/repository/sys-img/x86
wget -N http://dl-ssl.google.com/android/repository/sys-img/google_apis/sys-img.xml \
                         -P orig/android/repository/sys-img/google_apis
wget -N http://dl-ssl.google.com/android/repository/sys-img/android/sys-img.xml \
                         -P orig/android/repository/sys-img/android
wget -N http://dl-ssl.google.com/glass/gdk/addon.xml \
                         -P orig/glass/gdk
