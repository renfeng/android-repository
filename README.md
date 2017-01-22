# android-repository

This is a set of scripts for creating a mirror of Android Repository for Android SDK Manager (both standalone and Android Studio built-in) to download SDK packages from.

It's ideal for a classroom, [Study Jams](http://developerstudyjams.com/), and [Code labs](https://codelabs.developers.google.com/?cat=Android).

Tested on 

* Linux Mint Maya (13, Ubuntu 10.04)/Rebecca (17.1, Ubuntu 14.04),
* ~~OS X Yosemite (10.10.4)~~
* Cygwin on Windows 7 64bit

## Prerequisites

You'll need a lot of free storage on your disk, about 150GB as of 2017-01-12.

### Linux

sudo apt-get install xsltproc

(TODO test) yum install xsltproc

### OS X

It's recommended to use homebrew to install wget.
* http://brew.sh/
* http://www.merenbach.com/software/wget/

Ref.
* http://wget.addictivecode.org/Faq.html#download
* http://www.gnu.org/software/wget/
* http://google.com#q=wget

TODO test xsltproc on osx

### Cygwin

 * wget
 * xslt

 The two packages you must have are libxml2 and libxslt, both available under the Libs category.
 Ref. http://www.sagehill.net/docbookxsl/InstallingAProcessor.html#cygwin

## Setup your mirror and Android Standalone SDK Manager

https://docs.google.com/presentation/d/1JnGpK3YJrMY-f3M0pq6RkyAu2p-wct6DCwCOacCDGO8/pub

## Setup your mirror and Android Studio Built-in SDK Manager

Follow the same steps for Standalone SDK Manager, but run download2.sh, instead of download.sh.

Settings >> Appearance & Behavior >> System Settings >> HTTP Proxy
 * Manual proxy configuration
 * HTTP
 * Host name: studyjams.dushu.hu
 * Port number: 80
 * Check connection

Settings >> Appearance & Behavior >> System Settings >> Android SDK >> SDK Update Sites
 * Add sites with http. See https://docs.google.com/spreadsheets/d/1dTX0mhnEOVoqMebWnGllWM-5AIjgJ-oLuFsjmDd0mh4/edit#gid=822947052
 * Enable "Force https://... sources to be fetched using http://..."

### Known problem

[Missing SDK tools: CMake, LLDB, NDK](https://github.com/renfeng/android-repository/issues/9)

## (optional) SDK Web Manager

It's a single page app for exploring the packages downloaded. To make it work,
 1. In your web root directory, (backup your index.html, and) run
 
 `</path/to/android-repository/>setup-sdk-web-manager.sh`

 It will copy over three files and one directory.
  * index.html
  * .bowerrc
  * bower.json
  * elements/
 2. Install bower (requires nodejs, https://nodejs.org/), and run the following command line
 3. bower i -F -S

## Who's using it

At StudyJams and other events hosted by [GDG Suzhou](https://plus.google.com/100160462017014431473)

(To support this project, please [tell me about your mirror](mailto:renfeng.cn@gmail.com?subject=a+mirror+built+with+android-repository), and it'd be great if you wanted your mirror to be listed [here](https://github.com/renfeng/android-repository)!)
