#!/usr/bin/env bash

BASEDIR=$(dirname $0)
cp -r ${BASEDIR}/.bowerrc \
      ${BASEDIR}/bower.json \
      ${BASEDIR}/elements \
      ${BASEDIR}/index.html .

# https://docs.npmjs.com/getting-started/fixing-npm-permissions#option-2-change-npms-default-directory-to-another-directory
if [ ! -d ~/.npm-global ]; then
    mkdir ~/.npm-global
fi
npm config set prefix '~/.npm-global'
if [ `expr index "$PATH" "~/.npm-global/bin"` -eq 0 ]; then
    export PATH=~/.npm-global/bin:$PATH
fi

npm install -b bower
bower i
