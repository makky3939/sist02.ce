gulp       = require 'gulp'
coffee     = require 'gulp-coffee'
coffeeLint = require 'gulp-coffeelint'
concat     = require 'gulp-concat'
gulpPlumber = require 'gulp-plumber'

gulp.task 'coffee.app', ->
  gulp.src 'src/coffee/app.coffee'
    .pipe gulpPlumber
      errorHandler: (err) ->
        # console.log err
        this.emit 'end'
    .pipe coffeeLint()
    .pipe coffeeLint.reporter()
    .pipe coffee()
    .pipe gulpPlumber.stop()
    .pipe gulp.dest 'dst/js/'

gulp.task 'coffee.background', ->
  gulp.src 'src/coffee/background.coffee'
    .pipe gulpPlumber
      errorHandler: (err) ->
        # console.log err
        this.emit 'end'
    .pipe coffeeLint()
    .pipe coffeeLint.reporter()
    .pipe coffee()
    .pipe gulpPlumber.stop()
    .pipe gulp.dest 'dst/js/'

gulp.task 'coffee', ->
  gulp.start ['coffee.app', 'coffee.background']