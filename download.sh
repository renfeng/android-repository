# http://stackoverflow.com/questions/4944295/wget-skip-if-files-exist/16840827#16840827
# http://www.gnu.org/software/wget/manual/wget.html
wget -N https://dl-ssl.google.com/android/repository/repository-10.xml

# http://stackoverflow.com/questions/8535947/xslt-2-0-transformation-via-linux-shell
java -jar /usr/share/java/saxon.jar repository-10.xml repository-10.xsl | wget -N -i -

# make urls relative and local
cp repository-10.xml repository-10.orig
sed -i 's/https:\/\/dl-ssl.google.com\/android\/repository\///g' repository-10.xml
