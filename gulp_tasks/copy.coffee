gulp = require 'gulp'

gulp.task 'copy.json', ->
  gulp.src 'src/json/**', {base: 'src/json'}
    .pipe gulp.dest 'dst/'

gulp.task 'copy.image', ->
  gulp.src 'src/image/**', {base: 'src/image'}
    .pipe gulp.dest 'dst/image/'

gulp.task 'copy', ->
  gulp.start ['copy.json', 'copy.image']