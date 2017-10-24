
# Build processes using [Gulp](http://gulpjs.com)

Load Gulp modules.

    gulp = require 'gulp' # main tool
    shell = require 'gulp-shell' # run external commands

Here I'm commenting out some modules I'll want to use later, once source
code has been imported into this repository.

    #coffee = require 'gulp-coffee' # compile coffeescript
    #uglify = require 'gulp-uglify' # minify javascript
    #sourcemaps = require 'gulp-sourcemaps' # create source maps
    #pump = require 'pump' # good error handling of gulp pipes

Create a task to compile CoffeeScript source into JavaScript.  This is not
yet used, but will be later.

    gulp.task 'compile-source', -> pump [
        gulp.src 'src/*'
        sourcemaps.init()
        coffee bare : yes
        uglify()
        sourcemaps.write '.'
        gulp.dest '.'
    ]

Create "docs" task to build the documentation using
[MkDocs](http://www.mkdocs.org).  This requires that you have `mkdocs`
installed on your system.

    gulp.task 'docs', shell.task 'mkdocs build'

Create a default task that runs all other tasks.

    gulp.task 'default', [ 'docs' ]
