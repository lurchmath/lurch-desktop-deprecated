
# Getting Started

This documentation is for developers who wish to learn about the *Lurch Web
Platform,* and consider importing it into their own web projects.

## Try the demos online

You can [try out demo apps right now online](example-apps.md).  To use the
platform, you can simply import the necessary files from a CDN.

## Stop reading here!

Thta is, if you just want to use the platform in your own apps.  In that
case, check out the demo apps linked to above, or the
[developer tutorial](dev-tutorial.md).

Only continue reading below if you want to *help us develop the Lurch Web
Platform itself.*  In that case, you need to clone and set up this
repository on your machine.  Here's how:

## Setting up a local repository

Install [node.js](http://nodejs.org), which governs our building and testing
process.  (The apps run in a browser.)

Then execute these commands from a \*nix prompt:
 * Get the repository: `git clone https://github.com/lurchmath/lurch.git`
 * Enter that folder: `cd lurch`
 * Install node.js modules: `npm install`

To compile the source, you'll want to run the build command
[gulp](https://gulpjs.com/) from inside the `lurch` folder. You may need to
install gulp first; see its website.

You can also run `gulp test` to run the unit tests.

## Running a local web server

If you build an app on the Lurch Web Platform, and are testing it on your
local machine, , you need a web server (to avoid browser security concerns
with `file:///` URLs).  You almost certainly have Python installed, so in
the folder you're building your app, do this.
```
$ python -m SimpleHTTPServer 8000
```
Point your browser to `localhost:8000/yourpage.html`.
