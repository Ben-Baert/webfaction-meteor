# webfaction-meteor

## Deploy M&amp;M (Mongo/Node/Meteor) stack to Webfaction shared hosting

This project provides the `wfmtr` shell script for deploying M&amp;M stack (Mongo/Node/Meteor) to Webfaction servers.

> NOTE: This project is working mostly. I've deployed one app with it and refining. Please fork and submit pull requests.


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

You can type `wfmtr` to get the list of commands available. More docs as I have time to write them. For now the place to start is `bootstrap` and then `bundle appname` and then `run appname`. When you're satisfied that meteor is working, use `deploy appname` to grab your repo and push it live instead of the test app.

### `bootstrap`

Start here to get dependencies installed if necessary. Node.js, mongo, and meteor will be installed in your home directory.

Answer the series of questions to get the app ready and install a test meteor app to make sure it's all working.

### `bundle`

Bundle the test app and then run it to make sure things are OK then you can use the `deploy` command to actually check out your git repo project.



## Background

Why bash? I wrote something similar in python but sometimes shell scripts are just quicker to get from A to B. (and I wanted to get my head around python one-liners so that was part of this exercise)
