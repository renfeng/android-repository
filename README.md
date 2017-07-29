# android/repository

It mirrors Android SDKs, which Android Studio built-in and
standalone SDK Manager both can download from. Ideal for a crowded place,
e.g. classroom, [Study Jams](http://developerstudyjams.com/),
and [Code labs](https://codelabs.developers.google.com/?cat=Android).

Tested on 

* Linux Mint Rebecca (17.1, Ubuntu 14.04),
* Windows 7 64bit
* macOS Sierra (10.12.6)

## Prerequisites

* 51 GB storage on your disk, as of 2017-07-29
* wget
  * macOS, http://brew.sh/
  * Windows, install wget with [Cygwin](https://cygwin.com/install.html)
* xsltproc
  * Linux Mint/Ubuntu/Debian, ```sudo apt-get install xsltproc```
  * Windows, install libxml2 and libxslt with Cygwin, see http://www.sagehill.net/docbookxsl/InstallingAProcessor.html#cygwin

## Server setup

* Files will be downloaded to your working directory, which can be different than
* The directory the project is cloned into, referred as ```${ANDROID_REPOSITORY_HOME}``.
* The mirror can be hosted with an HTTP server. A sample Apache HTTPd vhost config will be printed on download complete.

For Android Studio Built-in SDK Manager
```
${ANDROID_REPOSITORY_HOME}/download2.sh
```

For Standalone SDK Manager
```
${ANDROID_REPOSITORY_HOME}/download.sh
```

By default, it downloads from https://dl.google.com. To download from elsewhere,
set environment variable, ```DL_HOST```. e.g.

```
export DL_HOST=https://dl-ssl.google.com
```

See also [Known Mirrors](https://github.com/renfeng/android-repository/wiki/Known-Mirrors).

## Client setup

After your server setup is complete, navigate to, ```http://<your.server>/android/studio/```, and find further instructions.

## Who's using it

At StudyJams and other events hosted by [GDG Suzhou](https://plus.google.com/100160462017014431473)

[Please let me know](mailto:renfeng.cn@gmail.com?subject=a+mirror+built+with+android-repository) if you'd like to publish your mirror [here](https://github.com/renfeng/android-repository).
