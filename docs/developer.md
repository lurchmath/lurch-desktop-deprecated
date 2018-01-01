
# Lurch Developer Docs

## A Development Platform

Rewriting the Lurch desktop app for the web involves building many
supporting tools that we call the *Lurch Web Platform.*  Other developers
can build math-enabled web apps on the same platform, which improves the
platform and grows the community.

We've made the architecture simple and the learning curve small.  [See the
demo applications and tutorial to start developing.](dev-tutorial.md)  We
are currently using the platform to build Lurch on the web.

## Architecture

The following table illustrates the software architecture.  Read it from the
bottom up.

<table>
  <tr>
    <td>Applications:</td>
    <td align=center><i>Lurch Proof Checker</i></td>
    <td align=center><a href='../dev-tutorial'>Demo apps</a></td>
    <td align=center>Your app</td>
  </tr>
  <tr>
    <td>Platform:</td>
    <td align=center colspan=3><i>Lurch Web Platform</i></td>
  </tr>
  <tr>
    <td>Foundation:</td>
    <td align=center colspan=3><a href='http://www.tinymce.com'>TinyMCE
        editor</a></td>
  </tr>
</table>

## Getting involved

If you're interested in helping out with development of this project (e.g.,
upstream commits if you use the platform), contact
[Nathan Carter](mailto:ncarter@bentley.edu).

## Repository details

All source code is in [literate
CoffeeScript](http://coffeescript.org/#literate).  This makes it highly
readable, especially on GitHub, which renders it as MarkDown.  I have tried
to be verbose in my comments, to help new readers.

Repository overview:

 * `/` (root folder)
    * `package.json` - used by [node.js](http://nodejs.org) to install
      dependencies  (The app runs in a browser, not node.js.  This is just
      for dev tools.)
    * `gulpfile.litcoffee` define the build process, which uses
      [gulp](https://gulpjs.com/)
    * `mkdocs.yml` defines how this documentation site is built, which uses
      [mkdocs](http://www.mkdocs.org/)
 * `docs`
    * All source files (Markdown) for this documentation site, which
      [mkdocs](http://www.mkdocs.org/) compiles into the `site` folder.
 * `site`
    * Compiled version of `doc-src/` folder, for hosting on GitHub Pages;
      you are seeing its contents here on this site
 * `source`
    * Source code files used for building the platform.
    * The build process compiles these into files in the `release` folder.
 * `unit-tests`
    * Unit tests.
    * To run them, execute `gulp test` in the main folder, after you've set
      it up as per [the Getting Started page](getting-started.md).
 * `release`
    * Demo apps and the plugins that create them reside here.  You can try
      them out live on the web; see
      [the demo apps and tutorials page](dev-tutorial.md).
    * The *Lurch Proof Checker* is being rewritten for the web and it will
      live in this folder later.
