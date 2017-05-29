# android-repository

This is a set of scripts for creating a mirror of Android Repository for Android SDK Manager (both standalone and Android Studio built-in) to download SDK packages from.

It's ideal for a classroom, [Study Jams](http://developerstudyjams.com/), and [Code labs](https://codelabs.developers.google.com/?cat=Android).

Tested on 

* Linux Mint Maya (13, Ubuntu 10.04)/Rebecca (17.1, Ubuntu 14.04),
* Cygwin on Windows 7 64bit

TODO test on OS X Yosemite (10.10.4)

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

TODO test xsltproc on macosx

### Cygwin

 * wget
 * xslt - The two packages you must have are libxml2 and libxslt, both available under the Libs category.
Ref. http://www.sagehill.net/docbookxsl/InstallingAProcessor.html#cygwin

## For Standalone SDK Manager

(Obsolete - GUI is replaced by command line, see next section) https://docs.google.com/presentation/d/1JnGpK3YJrMY-f3M0pq6RkyAu2p-wct6DCwCOacCDGO8/pub

## For Android Studio Built-in SDK Manager

N.B. files will be downloaded to your working directory. ANDROID_REPOSITORY_HOME is the directory holding the files of the project.

```
${ANDROID_REPOSITORY_HOME}/download.sh
```

Assuming your mirror will be hosted on studyjams.dushu.hu

```
#REPO_OS_OVERRIDE=windows
#REPO_OS_OVERRIDE=macosx
REPO_OS_OVERRIDE=linux
MIRROR_HOST=studyjams.dushu.hu
wget http://${MIRROR_HOST}/`wget http://${MIRROR_HOST}/studio/ -O - | grep -Po "android/repository/sdk-tools-${REPO_OS_OVERRIDE}-\d+.zip"`
unzip android/repository/sdk-tools-${REPO_OS_OVERRIDE}-*.zip
tools/bin/sdkmanager --no_https --proxy=http --proxy_host=${MIRROR_HOST} --proxy_port=80 'patcher;v4' 'extras;android;m2repository' 'extras;google;m2repository' emulator 'build-tools;25.0.3' 'platforms;android-25' platform-tools tools 'sources;android-25'
${ANDROID_REPOSITORY_HOME}/download2.sh
```

Settings >> Appearance & Behavior >> System Settings >> Android SDK >> SDK Update Sites
 * Add sites with http. See https://docs.google.com/spreadsheets/d/1dTX0mhnEOVoqMebWnGllWM-5AIjgJ-oLuFsjmDd0mh4/edit#gid=822947052
 * Enable "Force https://... sources to be fetched using http://..."

Settings >> Appearance & Behavior >> System Settings >> HTTP Proxy
 * Manual proxy configuration
 * HTTP
 * Host name: studyjams.dushu.hu
 * Port number: 80
 * Check connection

Tips: The settings are saved to (assuming 2.3 is the version of your Android Studio)

```
~/.android/repositories.cfg
~/.AndroidStudio2.3/config/options/remotesdk.xml
~/.AndroidStudio2.3/config/options/proxy.settings.xml
```

Sample [repositories.cfg](repositories.cfg)
```
### User Sources for Android Repository
#Mon May 29 07:06:05 CST 2017
count=9
enabled00=true
enabled01=true
enabled02=true
enabled03=true
enabled04=true
enabled05=true
enabled06=true
enabled07=true
enabled08=true
disp00=Android Repository Mirror
disp01=Android System Images Mirror
disp02=Android TV System Images Mirror
disp03=Android Wear System Images Mirror
disp04=Glass Development Kit, Google Inc. Mirror
disp05=Google API add-on System Images Mirror
disp06=Google API with Playstore System Images Mirror
disp07=Google Inc. Mirror
disp08=Intel HAXM Mirror
src00=http\://dl.google.com/android/repository/repository2-1.xml
src01=http\://dl.google.com/android/repository/sys-img/android/sys-img2-1.xml
src02=http\://dl.google.com/android/repository/sys-img/android-tv/sys-img2-1.xml
src03=http\://dl.google.com/android/repository/sys-img/android-wear/sys-img2-1.xml
src04=http\://dl.google.com/android/repository/glass/addon2-1.xml
src05=http\://dl.google.com/android/repository/sys-img/google_apis/sys-img2-1.xml
src06=http\://dl.google.com/android/repository/sys-img/google_apis_playstore/sys-img2-1.xml
src07=http\://dl.google.com/android/repository/addon2-1.xml
src08=http\://dl.google.com/android/repository/extras/intel/addon2-1.xml
```

Sample [remotesdk.xml](config/options/remotesdk.xml)
```
<application>
  <component name="StudioSettingsController">
    <option name="myForceHttp" value="true" />
  </component>
</application>
```

Sample [proxy.settings.xml](config/options/proxy.settings.xml) (the line for PROXY_PORT is omitted for the default http port, 80)
```
<application>
  <component name="HttpConfigurable">
    <option name="USE_HTTP_PROXY" value="true" />
    <option name="PROXY_HOST" value="studyjams.dushu.hu" />
    <option name="PROXY_PORT" value="80" />
  </component>
</application>
```

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

[Please let me know](mailto:renfeng.cn@gmail.com?subject=a+mirror+built+with+android-repository) if you'd like to publish your mirror [here](https://github.com/renfeng/android-repository).
