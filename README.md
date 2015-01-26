# android-repository

This is a set of scripts for creating a mirror of Android Repository, http://dl-ssl.google.com/android/repository/repository-10.xml

Works on Linux Mint Maya/13 (Ubuntu 10.04.x)

You'll need at least 4GB free storage on your disk.

## Why should you need this?

This is not for you, if you have no difficult to access the official Android repository, but for people without proper internet connection.

After downloading [Android Studio and SDK Tools](http://developer.android.com/sdk/), you'll need to add [SDK Packages](http://developer.android.com/sdk/installing/adding-packages.html). This project allows you to make a clone of the official Android repository, and later, host it with Apache HTTPd, nginx, lighttp, or any other static http content server, on your LAN.

It'll help you to distribute Android SDK packages in a classroom. Ideally, for [Android Fundamentals Study Jams](http://www.googledevelopersstudyjams.com/)

## Prerequisites

```
sudo aptitude install libsaxon-java default-jre
```

```
Package: libsaxon-java                   
State: installed
Automatically installed: yes
Version: 1:6.5.5-8
Priority: optional
Section: libs
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Architecture: all
Uncompressed Size: 626 k
Suggests: libjdom1-java, libsaxon-java-doc
Description: Saxon XSLT Processor
 The saxon package is a collection of tools for processing XML documents and implements the XSLT 1.0 recommendation, including XPath
 1.0, in its entirety. 
 
 Saxon is known to work well for processing DocBook XML documents with the DocBook XSL Stylesheets. Related packages make the
 process straightforward.
Homepage: http://saxon.sourceforge.net/
```
