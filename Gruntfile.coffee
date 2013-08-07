module.exports = (grunt) ->
  grunt.initConfig
    clean:
      build: ['build']
      release: ['dist']
    sass:
      dist:
        files:
          'build/sass/app.css': ['sass/base.sass']
    csslint:
      strict:
        src: ['build/sass/app.css', 'css/application.css']
    concat:
      dist:
        dest: 'build/css/app.css'
        src: ['build/sass/app.css', 'css/application.css']
    cssmin:
      compress:
        files:
          'dist/css/app.min.css': 'build/css/app.css'
    coffee:
      compile:
        files:
          'build/coffee/app.js': ['coffee/base.coffee']
    uglify:
      my_target:
        files:
          'dist/javascripts/app.min.js': ['build/coffee/app.js', 'javascripts/application.js']
    bower:
      install:
        options:
          targetDir: 'dist/javascripts'
          install: true
          verbose: false
          layout: 'byComponent'
          cleanTagetDir: true
          cleanBowerDir: false
    watch:
      html:
        files: ['*.html']
        options:
          livereload: true
      js:
        files: ['javascripts/*.js']
        tasks: ['uglify']
        options:
          livereload: true
      coffee:
        files: ['coffee/*.coffee']
        tasks: ['coffee', 'uglify']
        options:
          livereload: true
      css:
        files: ['css/*.css']
        tasks: ['csslint', 'concat', 'cssmin']
        options:
          livereload: true
      sass:
        files: ['sass/*.sass']
        tasks: ['sass', 'csslint', 'concat', 'cssmin']
        options:
          livereload: true
    connect:
      server:
        options:
          port: 9000

  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-csslint'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-connect'

  grunt.registerTask 'default', ['clean', 'bower:install', 'sass', 'csslint', 'concat', 'cssmin', 'coffee', 'uglify', 'connect', 'watch']
