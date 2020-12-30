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

* 127 GB storage on your disk, as of 2020-12-30
* wget
  * macOS, `brew install wget` (http://brew.sh/)
  * Windows, install wget with [Cygwin](https://cygwin.com/install.html)

## Server setup

Notes
* Files will be downloaded to your working directory, which can be different than
* The directory the project is cloned into, referred as `${ANDROID_REPOSITORY_HOME}`.
* The mirror can be hosted with an HTTP server. Sample configurations of Apache HTTPd and nginx will be printed at the end.

```bash
${ANDROID_REPOSITORY_HOME}/download2.sh
```

By default, it downloads from https://dl.google.com. To download from some mirror,
set environment variable, `DL_HOST`. e.g.

```bash
export DL_HOST=https://some-mirror
```

See also [Known Mirrors](https://github.com/renfeng/android-repository/wiki/Known-Mirrors).

## Client setup

Set environment variable, `SDK_TEST_BASE_URL`, and launch Android Studio e.g. on macOS

```bash
export SDK_TEST_BASE_URL=http://your-mirror/${DL_PATH}/
open -a 'Android Studio'
```
