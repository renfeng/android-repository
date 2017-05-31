# android-repository

This is a set of scripts for creating a mirror of Android Repository for Android SDK Manager (both standalone and Android Studio built-in) to download SDK packages from.

It's ideal for a classroom, [Study Jams](http://developerstudyjams.com/), and [Code labs](https://codelabs.developers.google.com/?cat=Android).

Tested on 

* Linux Mint Maya (13, Ubuntu 10.04)/Rebecca (17.1, Ubuntu 14.04),
* Cygwin on Windows 7 64bit
* OS X Mavericks (10.9.5)

## Prerequisites

You'll need a lot of free storage on your disk, about 40GB as of 2017-05-29.

### Linux

sudo apt-get install xsltproc

TODO test on redhat, yum install xsltproc

### OS X

It's recommended to use homebrew to install wget.
* http://brew.sh/
* http://www.merenbach.com/software/wget/

Ref.
* http://wget.addictivecode.org/Faq.html#download
* http://www.gnu.org/software/wget/
* http://google.com#q=wget

### Cygwin

 * wget
 * xslt - The two packages you must have are libxml2 and libxslt, both available under the Libs category.
Ref. http://www.sagehill.net/docbookxsl/InstallingAProcessor.html#cygwin

## For Standalone SDK Manager

### Server (Repository) setup

Note
* Files will be downloaded to your working directory.
* ANDROID_REPOSITORY_HOME is the directory holding the files of the project.
* A sample httpd vhost config will be printed on download complete

```
${ANDROID_REPOSITORY_HOME}/download.sh
```

### Client (SDK Manager) setup

Assuming your mirror will be hosted on studyjams.dushu.hu, the following will setup a client. Note. Java 8 is required.
```
MIRROR_HOST=studyjams.dushu.hu
OS=linux
#OS=darwin
#OS=windows
wget http://${MIRROR_HOST}/`wget http://${MIRROR_HOST}/studio/ -O - | perl -nle "print $& if m{android/repository/sdk-tools-${OS}-\d+.zip}"`
unzip sdk-tools-*.zip
tools/bin/sdkmanager --no_https --proxy=http --proxy_host=${MIRROR_HOST} --proxy_port=80 "patcher;v4" "extras;android;m2repository" "extras;google;m2repository" emulator "build-tools;25.0.3" "platforms;android-25" platform-tools tools "sources;android-25"
```

Tips: The settings are saved to
```
~/.android/repositories.cfg
```

Sample [repositories.cfg](repositories.cfg)

The command line version of standalone SDK manager replaces the GUI version, https://docs.google.com/presentation/d/1JnGpK3YJrMY-f3M0pq6RkyAu2p-wct6DCwCOacCDGO8/pub

### (Optional) SDK web manager setup

It's a single page app for exploring the packages downloaded. To make it work,
 1. In your web root directory, (backup your index.html, and) run

```
${ANDROID_REPOSITORY_HOME}/setup-sdk-web-manager.sh
```

 It will copy over three files and one directory.
  * index.html
  * .bowerrc
  * bower.json
  * elements/
 2. Install bower (requires nodejs, https://nodejs.org/), and run the following command line
 3. bower i -F -S

## For Android Studio Built-in SDK Manager

### Server (Repository) setup

Note
* Files will be downloaded to your working directory.
* ANDROID_REPOSITORY_HOME is the directory holding the files of the project.
* A sample httpd vhost config will be printed on download complete

```
${ANDROID_REPOSITORY_HOME}/download2.sh
```

### Client (Android Studio) setup

Set environment variable before launching Android Studio.
```
export SDK_TEST_BASE_URL=http://studyjams.dushu.hu/android/repository/
```

Ref. https://android.googlesource.com/platform/sdk/+/tools_r14

## Who's using it

At StudyJams and other events hosted by [GDG Suzhou](https://plus.google.com/100160462017014431473)

[Please let me know](mailto:renfeng.cn@gmail.com?subject=a+mirror+built+with+android-repository) if you'd like to publish your mirror [here](https://github.com/renfeng/android-repository).
