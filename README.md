# android/repository

This is a set of scripts for creating a mirror of Android Repository for Android SDK Manager (both standalone and Android Studio built-in) to download SDK packages from.

It's ideal for a classroom, [Study Jams](http://developerstudyjams.com/), and [Code labs](https://codelabs.developers.google.com/?cat=Android).

Tested on 

* Linux Mint Maya (13, Ubuntu 10.04)/Rebecca (17.1, Ubuntu 14.04),
* Cygwin on Windows 7 64bit
* OS X Mavericks (10.9.5)

## Prerequisites

* 51 GB storage on your disk, as of 2017-07-29
* bower, https://bower.io/#install-bower
* wget
  * macOS, http://brew.sh/
  * Windows, install wget with [Cygwin](https://cygwin.com/install.html)
* xsltproc
  * Linux Mint/Ubuntu/Debian, ```sudo apt-get install xsltproc```
  * Windows, install libxml2 and libxslt with Cygwin, see http://www.sagehill.net/docbookxsl/InstallingAProcessor.html#cygwin

## Server setup

### For Android Studio Built-in SDK Manager

Note
* Files will be downloaded to your working directory.
* ANDROID_REPOSITORY_HOME is the directory holding the files of the project.
* A sample httpd vhost config will be printed on download complete

```
${ANDROID_REPOSITORY_HOME}/download2.sh
```

### For Standalone SDK Manager

Note
* Files will be downloaded to your working directory.
* ANDROID_REPOSITORY_HOME is the directory holding the files of the project.
* A sample httpd vhost config will be printed on download complete

```
${ANDROID_REPOSITORY_HOME}/download.sh
```

## Client setup

After your server setup is complete, navigate to, ```http://<your.server>/android/studio/```, and find further instructions.

## Who's using it

At StudyJams and other events hosted by [GDG Suzhou](https://plus.google.com/100160462017014431473)

[Please let me know](mailto:renfeng.cn@gmail.com?subject=a+mirror+built+with+android-repository) if you'd like to publish your mirror [here](https://github.com/renfeng/android-repository).
