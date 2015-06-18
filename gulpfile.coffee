gulp = require 'gulp'
requireDir = require 'require-dir'
runSequence = require 'run-sequence'

dir = requireDir './gulp_tasks'

defaultTasks = ['copy', 'jade', 'coffee']

gulp.task 'watch', ->
  gulp.watch 'src/jade/**', ['jade']
  gulp.watch 'src/coffee/**', ['coffee']
  gulp.watch 'src/json/**', ['copy.json']
  gulp.watch 'src/image/**', ['copy.image']

gulp.task 'build', ->
  runSequence 'clean', defaultTasks

gulp.task 'develop', ->
  runSequence 'clean', defaultTasks, 'watch'