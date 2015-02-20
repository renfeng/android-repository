# android-repository

This is a set of scripts for creating a mirror of Android Repository, http://dl-ssl.google.com/android/repository/addons_list-2.xml

Works on Linux Mint Maya/13 (Ubuntu 10.04.x)

You'll need at least 11GB free storage on your disk.

## Who's using it

http://studyjams.dushu.hu, and also on their LAN

(Please, insert your mirror url)

## How to setup your mirror/server?

assume $script is a directory you want to save the project

git clone https://github.com/renfeng/android-repository $script

this will sync all sdk packages into your current directory

$script/download.sh

Setup a static content server, e.g. Apache HTTPd, lighttp, nginx, ..., to host the content of your current directory, and make it accessible through http

## How to setup your client, i.e. Android SDK Manager

Edit $script/client/repositories.cfg, and change studyjams.dushu.hu to your mirror

this will make Android SDK Manager to download packages from your mirror

$script/client/setup.sh

this will restore Android SDK Manager to download packages from the official repository

script/client/clean.sh

## Why should you need this?

This is not for you, if you have no difficulty in downloading Android SDK packages from the official Android repository, but for people without proper internet connection.

After downloading [Android Studio and SDK Tools](http://developer.android.com/sdk/), you'll need to add [SDK Packages](http://developer.android.com/sdk/installing/adding-packages.html). This project allows you to make a clone of the official Android repository, and later, host it with Apache HTTPd, nginx, lighttp, or any other static http content server, on your LAN.

It'll help you to distribute Android SDK packages in a classroom. Ideally, for [Android Fundamentals Study Jams](http://www.googledevelopersstudyjams.com/)

## Where does saxon.jar come from?

It was copied from /usr/share/java/saxon.jar, which was installed on a Linux Mint Maya (13)

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

## For Windows Users

Tested with latest cygwin 64bit on Windows 7

## For Mac Users

TODO test

## This is GIT

Don't forget this is git - you can do whatever you want to make it better!
