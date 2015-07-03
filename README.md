# android-repository

This is a set of scripts for creating a mirror of Android Repository where SDK Manager downloads SDK packages.

Tested on Linux Mint Maya(13, Ubuntu 10.04)/Rebecca(17.1, Ubuntu 14.04), and Cygwin on Windows 7 64bit

You'll need at least 27GB free storage on your disk.

## Who's using it

http://studyjams.dushu.hu, and also on LAN at events hosted by [GDG Suzhou](https://plus.google.com/100160462017014431473/)

(You can add your mirror created with the scripts, here)

## Why should you need this?

It'll help you to distribute Android SDK packages in a classroom. Ideally, for [Android Fundamentals Study Jams](http://www.googledevelopersstudyjams.com/)

For more information, please follow the link in the next section.

## How to setup your mirror/server, and client, i.e. Android SDK Manager

https://docs.google.com/presentation/d/1JnGpK3YJrMY-f3M0pq6RkyAu2p-wct6DCwCOacCDGO8/pub

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

## This is GIT

Don't forget this is git - you can do whatever you want to make it better!
