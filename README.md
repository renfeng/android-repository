# android-repository

This is a set of scripts for creating a mirror of Android Repository where SDK Manager downloads SDK packages.

Tested on 

* Linux Mint Maya(13, Ubuntu 10.04)/Rebecca(17.1, Ubuntu 14.04),
* OS X Yosemite (10.10.4)
* Cygwin on Windows 7 64bit

You'll need at least 102GB free storage on your disk.

## Linux

sudo apt-get install xsltproc

(TODO test) yum install xsltproc

## OS X

It's recommended to use homebrew to install wget.

* http://brew.sh/
* http://www.merenbach.com/software/wget/
* http://wget.addictivecode.org/FrequentlyAskedQuestions?action=show&redirect=Faq#download
* http://www.gnu.org/software/wget/
* http://google.com#q=wget

You need also to download and install JDK.

TODO test xsltproc on osx

## Cygwin

 * wget

 * xslt

 The two packages you must have are libxml2 and libxslt, both available under the Libs category.
 Ref. http://www.sagehill.net/docbookxsl/InstallingAProcessor.html#cygwin

## SDK Web Manager

packages.html

## Who's using it

http://studyjams.dushu.hu, and also on LAN at events hosted by [GDG Suzhou](https://plus.google.com/100160462017014431473/)

(You can add your mirror created with the scripts, here)

## Why should you need this?

It'll help you to distribute Android SDK packages in a classroom. Ideally, for [Android Fundamentals Study Jams](http://www.googledevelopersstudyjams.com/)

For more information, please follow the link in the next section.

## How to setup your mirror/server, and client, i.e. Android SDK Manager

https://docs.google.com/presentation/d/1JnGpK3YJrMY-f3M0pq6RkyAu2p-wct6DCwCOacCDGO8/pub

## This is GIT

Don't forget this is git - you can do whatever to make it better!
