wget http://dl-ssl.google.com/android/repository/repository-10.xml
java -jar /usr/share/java/saxon.jar repository-10.xml repository-10.xsl | wget -i -
