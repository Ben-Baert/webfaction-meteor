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


## Usage

The `install.sh` script does the following:

 * creates a `$HOME/bin` directory if it doesn't exist to store localized binaries (node, npm, meteor, mongod, mongo etc.)
 * creates a `$HOME/.wfmtr` directory if it doesn't exist to store configurations
 * checks your current `$PATH` for your home bin directory and adds an export statement if necessary
 * copies the `wfmtr` script to your bin directory and makes it executable
 
You can type `wfmtr` to get the list of commands available. More docs as I have time to write them. For now the place to start is `bootstrap` and then `bundle appname` and then `run appname`. When you're satisfied that meteor is working, use `deploy appname` to grab your repo and push it live instead of the test app.

In detail, the `wfmtr` bash script does the following:

#### `bootstrap`
 1. **Installs dependencies** (you only need to do this once)
   * prompts to install (Node.js)[http://nodejs.org] to your `$HOME/bin` directory
     * uses `--prefix=$HOME` so you can find `node_modules` in `$HOME/lib`
   * prompts to install (MongoDB)[http://mongodb.org] to your `$HOME/bin` directory
     * uses the compiled binaries for Linux x86_64 so you should be on a 64 bit machine (most new ones are)
   * prompts to install (Meteor)[http://meteor.com] to your `$HOME/bin` directory
     * this changes the meteor install script to set the `PREFIX=$HOME` which then also creates a `$HOME/.meteor` directory
 2. **Creates webfaction apps**
   * creates two custom apps "listening on port" for meteor and mongo:
     * The first app `app_name`:
       * provides the port meteor runs on and is connected to the website
       * is the root/base where your meteor code is checked out from your git repo to
     * The second app `app_name_bin`:
       * provides an additional port for mongo to run on
       * is where the app is bundled for deployment
       * is where all the log and pid files live
 3. **Creates placeholder meteor app**
   * creates a default meteor app in `$HOME/tmp` then rsyncs to the empty `$HOME/webapps/app_name` folder
 4. **Writes config**
   * writes the environment config file to `$HOME/.wfmtr/app_name.conf`

#### `bundle`
 1. **Applies settings.json**
   * checks if a settings.json file exists in the root of the project and adds it to the env config file
 2. **Builds Meteor app**
   * builds the meteor app in the `app_name_bin` directory using `meteor build --directory $HOME/webapps/app_name_bin`
   * per the meteor build `README`, installs node dependencies using `(cd programs/server && npm install)` within the bundle 

#### `deploy`
 1. **Clones repo**
   * simple check if a `.git` folder exists in the app
   * the git repo code is clone out to `$HOME/tmp/app_name-timestamp` folder and then rsyncs into the existing app, replacing it's contents.
 2. **Applies settings.json**
   * checks if a settings.json file exists in the root of the project and adds it to the env config file
 3. **Builds Meteor app**
   * builds the meteor app in the `app_name_bin` directory using `meteor build --directory $HOME/webapps/app_name_bin`
   * per the meteor build `README`, installs node dependencies using `(cd programs/server && npm install)` within the bundle directory
 4. **Creates website**
   * deletes the site named like `app_name_site` for the current IP address
   * creates the site named like `app_name_site` for the current IP address, host name, and app name
   * **this process is kind of broken**
     * need to implement check if site already exists
     * need to confirm ip address and host name as it's possible you have multiple servers

#### `run`
 1. **Checks for bundle**
   * looks for bundle directory in `app_name_bin`
   * checks if app is running (*broken?*)
 2. **Restarts or Starts Mongo**
   * checks if mongo is running and starts it
 2. **Restarts or Starts Forever.js**
   * performs a `forever restart` or `forever start` to get the app going
   * logs are appended to

#### `stop`
 1. **Checks for bundle**
   * looks for bundle directory in `app_name_bin`
 2. **Stops Forever.js**
   * performs a `forever stop`

#### `restart`
 1. **wrapper for stop() then run()**
   * looks for bundle directory in `app_name_bin`


## Broken Things

The following *features* aren't working at the moment and need some collaborative love in the form of suggestions, pull requests or time on my part. Log an issue and it'll be top of mind.

 * mongo isn't tested as my current app doesn't use it
 * domains and subdomains aren't working reliably so for now create the domains manually in the control panel
 * `deploy` works but you'll get errors about the domain not existing or site not existing
 * need to consolidate the deploy and bundle steps - maybe just one step or an update step that works more intuitively


## Structuring your app

If you want to use the deploy tool you'll need to make sure your meteor app runs from the root of your repo, not a subdirectory. This is pretty standard but worth mentioning.


## Background

Why bash? I wrote something similar in python but sometimes shell scripts are just quicker to get from A to B. (and I wanted to get my head around python one-liners so that was part of this exercise)
