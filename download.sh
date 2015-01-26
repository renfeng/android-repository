wget http://dl-ssl.google.com/android/repository/repository-10.xml

# http://stackoverflow.com/questions/8535947/xslt-2-0-transformation-via-linux-shell
java -jar /usr/share/java/saxon.jar repository-10.xml repository-10.xsl | wget -i -
