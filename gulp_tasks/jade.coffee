gulp = require 'gulp'
jade = require 'jade'
gulpJade = require 'gulp-jade'
gulpPlumber = require 'gulp-plumber'

gulp.task 'jade', ->
  gulp.src 'src/jade/index.jade'
    .pipe gulpPlumber
      errorHandler: (err) ->
        console.log err
        this.emit 'end'
    .pipe gulpJade
      basedir: 'src/jade/'
    .pipe gulpPlumber.stop()
    .pipe gulp.dest 'dst/'