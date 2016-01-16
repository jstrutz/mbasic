var gulp = require('gulp');
var mocha = require('gulp-mocha');
var util = require('gulp-util');

gulp.task('test', function() {
  return gulp.src(['test/**/*_test.js'], { read: false})
    .pipe(mocha({ reporter: 'spec' }))
    .on('error', util.log);
});

gulp.task('test:watch', function () {
  gulp.watch(['src/**', 'lib/**', 'test/**'], ['test']);
});
