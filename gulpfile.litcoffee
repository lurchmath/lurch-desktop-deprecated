
# Build processes using [Gulp](http://gulpjs.com)

## Preparation

Load Gulp modules.

    fs = require 'fs' # for loading resources
    gulp = require 'gulp' # main tool
    shell = require 'gulp-shell' # run external commands
    coffee = require 'gulp-coffee' # compile coffeescript
    uglify = require 'gulp-uglify' # minify javascript
    sourcemaps = require 'gulp-sourcemaps' # create source maps
    pump = require 'pump' # good error handling of gulp pipes
    concat = require 'gulp-concat' # for uniting source files
    each = require 'gulp-each' # for manual tweaks in gulp streams
    addsrc = require 'gulp-add-src' # for merging files in streams

## Build tools

The following function is useful for embedding any outside resource into a
JavaScript/CoffeeScript file.  It takes these arguments:
 1. The filename containing the content to embed.
 2. The MIME type of the data in that file, e.g. `"image/png"`.
 3. The filename of the source code in which to embed the data.  This file
    will be prepended with a single variable declaration, initialized to a
    big, base64-encoded string containing a data URI.
 4. The name of the global variable to create.  Options:
     * One identifier, such as `"myData"` (useful in CoffeeScript)
     * Variable declaration, such as `"var myData"` (useful in JavaScript)
     * Dot notation, such as `"window.myObj.myData"` (useful in either)
     * One identifier with spaces in front of it (literate CoffeeScript)
 5. The code string to replace with the global variable (optional).  For
    instance, if your code contains the string `"../img/mypicture.png"` and
    you would like that replaced with the name of the global variable
    containing the data URI, pass `'"../img/mypicture.png"'` as the value
    of this third parameter, and all instances of that string literal will
    be replaced with the name of the new variable.  Set this to null to do
    no replacements.
 6. The filename into which to output the results.

This function is synchronous and immediate, not using the gulp ecosystem.

    embedAsVariableIn = ( fileToEmbed, mimeType, codeFile, varName,
                          toReplace, outFile ) ->
        toEmbed = fs.readFileSync fileToEmbed
        encoded = ( new Buffer toEmbed ).toString 'base64'
        declaration = "#{varName} = 'data:#{mimeType};base64,#{encoded}'"
        code = String fs.readFileSync codeFile
        while toReplace? and -1 < code.indexOf toReplace
            code = code.replace toReplace, varName
        fs.writeFileSync outFile, "#{declaration}\n\n#{code}"

Next we define a function that compiles CoffeeScript to JavaScript, with
minification and source maps.

Its first parameter should be the product of a call to `gulp.src`, or
something equivalent (like the output of a pipe, or the `embedResource`
function just defined).  If a string or array is passed instead, that will
be given to `gulp.src` first.

Its second parameter will be passed directly to `gulp.dest`.

    compileAndMinify = ( sources, destination ) ->
        if sources instanceof Array or 'string' is typeof sources
            sources = gulp.src sources
        pump [
            sources
            sourcemaps.init()
            coffee bare : yes
            uglify()
            sourcemaps.write '.'
            gulp.dest destination
        ]

## Contents of a release

Create a task to concatenate all the source code files that make up the
Lurch Web Platform.

    gulp.task 'lwp-source', -> pump [
        gulp.src [
            'source/modules/utils.litcoffee'
            'source/modules/domutils.litcoffee'
            'source/modules/canvasutils.litcoffee'
            'source/plugins/*.litcoffee'
            'source/auxiliary/keyboard-shortcuts-workaround.litcoffee'
            'source/auxiliary/testrecorder-setup.litcoffee'
            'source/auxiliary/setup.litcoffee'
        ]
        concat 'lurch-web-platform.litcoffee'
        gulp.dest 'release/'
    ]

Create a task to compile the large file created by the previous task.  We
use minification and source maps.

    gulp.task 'lwp-build', gulp.series 'lwp-source', ->
        compileAndMinify 'release/lurch-web-platform.litcoffee', 'release/'

Create a set of tasks to compile (with minification and source maps) a set
of auxiliary source files, embedding resources where needed.

First, here are the auxiliary files:

    auxFiles = [
        'source/auxiliary/lurch-embed.litcoffee'
        'source/auxiliary/mathquill-parser.litcoffee'
        'source/auxiliary/testrecorder-page.litcoffee'
        'source/auxiliary/worker.litcoffee'
        'source/auxiliary/xml-groups.litcoffee'
    ]

Here is a task for copying source files (so that source maps point to files
that exist), and then a task for compiling those same source files.

    gulp.task 'aux-copy', -> pump [
        gulp.src auxFiles
        gulp.dest 'release/'
    ]
    gulp.task 'aux-build', gulp.series 'aux-copy', ->
        compileAndMinify auxFiles, 'release/'

We must also treat the background module specially:  First, it depends upon
`aux-build` having completed, so that we can use `worker.js` as a resource.
Second, it embeds that resource into the background module before compiling.

    gulp.task 'aux-with-bg', gulp.series 'aux-build', ->
        embedAsVariableIn 'release/worker.js', 'text/javascript',
            'source/auxiliary/background.litcoffee', '    workerScript',
            "'worker.js'", 'release/background.litcoffee'
        compileAndMinify 'release/background.litcoffee', 'release/'

The final task is that of building a release, which includes all the tasks
above, plus one for copying all `source/assets` into the release folder.

    gulp.task 'copy-assets', -> pump [
        gulp.src [ 'source/assets/**/*', '!source/assets/README.md' ]
        gulp.dest 'release'
    ]
    gulp.task 'release-build', gulp.series \
        'lwp-build', 'aux-with-bg', 'copy-assets'

## Other build tasks

Create a task to compile (with minification and source maps) all source
files in the `experimental` folder, into that same folder.  This folder is
not in the repository, because its purpose is to let individual developers
experiment with temporary/ancillary files on their own machine before adding
new features to the repository.

    gulp.task 'exp-build', ->
        compileAndMinify 'source/experimental/*.litcoffee',
            'source/experimental/'

Create "docs" task to build the documentation using
[MkDocs](http://www.mkdocs.org).  This requires that you have `mkdocs`
installed on your system.

    gulp.task 'docs', shell.task 'mkdocs build'

Create a "test" task to run unit tests.  So far it only runs one of the
unit tests.  The reason for this is that the others are out-of-date, and
require a main app page, which this repository does not yet build.

    gulp.task 'test', gulp.series 'release-build', ->
        gulp.src [
            'unit-tests/utils-spec.litcoffee'
        ], read : no
        .pipe shell [
            'echo "-------------------------------------------"'
            'echo "-"'
            'echo "-  BEGINNING TESTS FOR: <%= file.path %>"'
            'echo "-"'
            'echo "-------------------------------------------"'
            './node_modules/.bin/jasmine-node --verbose --coffee
            --forceexit <%= file.path %>'
        ]

## Pulling it all together

Create a default task that runs all other tasks.

    gulp.task 'default', gulp.series \
        'release-build', 'exp-build', 'docs'
