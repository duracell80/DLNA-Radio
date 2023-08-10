#!/bin/bash

DIR_PWD=$(pwd)
DIR_APP=$DIR_PWD/app
APP_NME=${PWD##*/}
DIR_BSE=$HOME/python-apps/$APP_NME


PIP_INS=$(which python | sed -n "s/.*\(${APP_NME}\).*/\1/p" | wc -l)

if [ ! -f "./bin/activate" ]; then
	#echo "[!] Venv not detected try running this script from ~/python-apps/${APP_NME}"
	#exit
	cd $DIR_BSE/app && $DIR_BSE/app/main.py
fi

if [[ $PIP_INS == 0 ]]; then
  echo -e "[i] Venv active for ${APP_NME}, type exit to deactivate and ./run.sh to run the app in the venv"
  bash -c "source bin/activate; exec /usr/bin/env bash --rcfile <(echo 'PS1=\"(${APP_NME})\${PS1}\"') -i"
else
  echo "[i] Running App from within ... $(pwd)"
  cd $DIR_APP && $DIR_APP/main.py
fi
