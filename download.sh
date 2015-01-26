# TODO save file with path
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


mkdir -p extras/intel
mkdir -p sys-img/android-tv
mkdir -p sys-img/android-wear
mkdir -p sys-img/x86
mkdir -p sys-img/google_apis
mkdir -p sys-img/android

# http://stackoverflow.com/questions/4944295/wget-skip-if-files-exist/16840827#16840827
# http://www.gnu.org/software/wget/manual/wget.html
wget -N https://dl-ssl.google.com/android/repository/extras/intel/addon.xml -P extras/intel
wget -N https://dl-ssl.google.com/android/repository/addon-6.xml
wget -N https://dl-ssl.google.com/android/repository/sys-img/android-tv/sys-img.xml -P sys-img/android-tv
wget -N https://dl-ssl.google.com/android/repository/repository-10.xml
wget -N https://dl-ssl.google.com/android/repository/sys-img/android-wear/sys-img.xml -P sys-img/android-wear
wget -N https://dl-ssl.google.com/android/repository/addon.xml
wget -N https://dl-ssl.google.com/android/repository/sys-img/x86/addon-x86.xml -P sys-img/x86
wget -N https://dl-ssl.google.com/android/repository/sys-img/google_apis/sys-img.xml -P sys-img/google_apis
wget -N https://dl-ssl.google.com/android/repository/sys-img/android/sys-img.xml -P sys-img/android

# http://stackoverflow.com/questions/8535947/xslt-2-0-transformation-via-linux-shell
java -jar /usr/share/java/saxon.jar extras/intel/addon.xml extras/intel/addon.xsl | wget -N -P extras/intel -i -
java -jar /usr/share/java/saxon.jar addon-6.xml addon-6.xsl | wget -N -i -
java -jar /usr/share/java/saxon.jar sys-img/android-tv/sys-img.xml sys-img/android-tv/sys-img.xsl | wget -N -P sys-img/android-tv -i -
# requires 4GB
java -jar /usr/share/java/saxon.jar repository-10.xml repository-10.xsl | wget -N -i -
java -jar /usr/share/java/saxon.jar sys-img/android-wear/sys-img.xml sys-img/android-wear/sys-img.xsl | wget -N -P sys-img/android-wear -i -
java -jar /usr/share/java/saxon.jar addon.xml addon.xsl | wget -N -i -
java -jar /usr/share/java/saxon.jar sys-img/x86/addon-x86.xml sys-img/x86/addon.xsl | wget -N -P sys-img/x86 -i -
java -jar /usr/share/java/saxon.jar sys-img/google_apis/sys-img.xml sys-img/google_apis/sys-img.xsl | wget -N -P sys-img/google_apis -i -
java -jar /usr/share/java/saxon.jar sys-img/android/sys-img.xml sys-img/android/sys-img.xsl | wget -N -P sys-img/android -i -

# make urls relative and local
cp extras/intel/addon.xml extras/intel/addon.xml.orig
sed -i 's/https:\/\/dl-ssl.google.com\/android\/repository\///g' extras/intel/addon.xml

cp addon-6.xml addon-6.xml.orig
sed -i 's/https:\/\/dl-ssl.google.com\/android\/repository\///g' addon-6.xml

cp sys-img/android-tv/sys-img.xml sys-img/android-tv/sys-img.xml.orig
sed -i 's/https:\/\/dl-ssl.google.com\/android\/repository\///g' sys-img/android-tv/sys-img.xml

cp repository-10.xml repository-10.xml.orig
sed -i 's/https:\/\/dl-ssl.google.com\/android\/repository\///g' repository-10.xml

cp sys-img/android-wear/sys-img.xml sys-img/android-wear/sys-img.xml.orig
sed -i 's/https:\/\/dl-ssl.google.com\/android\/repository\///g' sys-img/android-wear/sys-img.xml

cp addon.xml addon.xml.orig
sed -i 's/https:\/\/dl-ssl.google.com\/android\/repository\///g' addon.xml

cp sys-img/x86/addon-x86.xml sys-img/x86/addon-x86.xml.orig
sed -i 's/https:\/\/dl-ssl.google.com\/android\/repository\///g' sys-img/x86/addon-x86.xml

cp sys-img/google_apis/sys-img.xml sys-img/google_apis/sys-img.xml.orig
sed -i 's/https:\/\/dl-ssl.google.com\/android\/repository\///g' sys-img/google_apis/sys-img.xml

cp sys-img/android/sys-img.xml sys-img/android/sys-img.xml.orig
sed -i 's/https:\/\/dl-ssl.google.com\/android\/repository\///g' sys-img/android/sys-img.xml

# verify
grep -Prn '<sdk:url>' * --exclude=*.orig | grep http
