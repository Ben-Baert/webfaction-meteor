# webfaction-meteor

## Deploy M&amp;M (Mongo/Node/Meteor) stack to Webfaction shared hosting

This project provides the `wfmtr` shell script for deploying M&amp;M stack (Mongo/Node/Meteor) to Webfaction servers.

> NOTE: This project is not ready. Check back later TODAY.


## Installation

In an ssh session on your webfaction server, copy and paste this line to the Terminal and press Enter. Installer may ask for your password.

Using `curl`

    curl https://raw.githubusercontent.com/mogga/webfaction-meteor/master/install.sh | bash

Or `wget`

    wget -qO- https://raw.githubusercontent.com/mogga/webfaction-meteor/master/install.sh | bash

<sub>The script checks if you have `~/bin` and `~/.wfmtr` directories, creates them if necessary, copies the `wfmtr` script to your `~/bin` directory and then adds `~/bin` to your `PATH` if it isn't already there.</sub>

## Structuring your app

If you want to use the deploy tool you'll need to make sure your meteor app runs from the root of your repo, not a subdirectory. This is pretty standard but worth mentioning.


## Usage

More to come here...

    Usage: wfmtr [bootstrap|deploy|update|run|stop]


## Background

Why bash? I wrote something similar in python but sometimes shell scripts are just quicker to get from A to B. (and I wanted to get my head around python one-liners so that was part of this exercise)
