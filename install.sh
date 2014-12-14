#!/usr/bin/env bash

USER_BIN="$HOME/bin"
USER_WFMTR="$HOME/.wfmtr"
WFMTR_GITHUB_URL="https://raw.githubusercontent.com/mogga/webfaction-meteor/master/install.sh"

[[ -d "$USER_BIN" ]] || mkdir $USER_BIN
[[ -d "$USER_WFMTR" ]] || mkdir $USER_WFMTR

if [[ ":$PATH:" != *":$USER_BIN:"* ]]; then
  echo "PATH=\$PATH:$USER_BIN">>~/.bashrc
  echo "export \$PATH">>~/.bashrc
  hash -r
fi

(cd $USER_BIN; curl -O https://raw.githubusercontent.com/mogga/webfaction-meteor/master/wfmtr)

chmod 750 $USER_BIN/wfmtr

echo -e "\nInstalled wfmtr in $USER_BIN\n"
