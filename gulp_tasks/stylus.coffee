gulp       = require 'gulp'
stylus     = require 'gulp-stylus'
gulpPlumber = require 'gulp-plumber'

gulp.task 'stylus', ->
  gulp.src 'src/sass/style.sass'
    .pipe gulpPlumber
      errorHandler: (err) ->
        # console.log err
        this.emit 'end'
    .pipe stylus()
    .pipe gulpPlumber.stop()
    .pipe gulp.dest 'dst/css/'