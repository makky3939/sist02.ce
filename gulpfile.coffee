gulp = require 'gulp'
requireDir = require 'require-dir'
runSequence = require 'run-sequence'

dir = requireDir './gulp_tasks'

defaultTasks = ['copy', 'jade', 'coffee']

gulp.task 'watch', ->
  gulp.watch 'src/jade/**', ['jade']

gulp.task 'build', ->
  runSequence 'clean', defaultTasks

gulp.task 'develop', ->
  runSequence 'clean', defaultTasks, 'watch'