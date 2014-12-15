# webfaction-meteor

## Deploy M&amp;M (Mongo/Node/Meteor) stack to Webfaction shared hosting

This project provides the `wfmtr` shell script for deploying M&amp;M stack (Mongo/Node/Meteor) to Webfaction servers.

> NOTE: This project is working mostly. I've deployed one app with it and refining. Please fork and submit pull requests.

## What `wfmtr` actually does

The install script does the following:

 * creates a `$HOME/bin` directory if it doesn't exist to store localized binaries (node, npm, meteor, mongod, mongo etc.)
 * creates a `$HOME/.wfmtr` directory if it doesn't exist to store configurations
 * checks your current `$PATH` for your home bin directory and adds an export statement if necessary
 * copies the `wfmtr` script to your bin directory and makes it executable
 
The `wfmtr` bash script does the following:

#### `bootstrap`
 1. **Installs dependencies** (you only need to do this once)
   * prompts to install (Node.js)[http://nodejs.org] to your `$HOME/bin` directory
     * uses `--prefix=$HOME` so you can find `node_modules` in `$HOME/lib`
   * prompts to install (MongoDB)[http://mongodb.org] to your `$HOME/bin` directory
     * uses the compiled binaries for Linux x86_64 so you should be on a 64 bit machine (most new ones are)
   * prompts to install (Meteor)[http://meteor.com] to your `$HOME/bin` directory
     * this changes the meteor install script to set the `PREFIX=$HOME` which then also creates a `$HOME/.meteor` directory
2. **Creates apps**
   * creates two custom apps listening on ports for meteor and mongo
     * the first app `app_name` is where your meteor app is checked out from your git repo and is the port meteor runs on and should be connected to the website
     * the second app `app_name_bin` is where the app is bundled and all the log and pid files live and provides an additional port for mongo to run on
   * writes the environment config file to `$HOME/.wfmtr/app_name.conf`

#### `deploy`

#### `bundle`

#### `run`

#### `stop`

#### `restart`

> **in the process of writing this**

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
