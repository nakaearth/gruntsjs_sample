module.exports = (grunt) ->
  grunt.initConfig
    clean:
      build: ['build']
      release: ['lib']
    sass:
      dist:
        files:
          'build/css/app.css': ['sass/base.sass']
    csslint:
      strict:
        src: ['builod/css/app.css', 'css/application.css']
    concat:
      dist:
        dest: 'build/css/app.css'
        src: ['build/css/app.css', 'css/application.css']
    cssmin:
      compress:
        files:
          'lib/css/app.min.css': 'build/css/app.css'
    coffee:
      compile:
        files:
          'build/javascripts/app.js': ['coffee/base.coffee']
    uglify:
      my_target:
        files:
          'lib/javascripts/app.min.js': ['build/javascripts/app.js', 'javascripts/application.js']
    bower:
      install:
        options:
          targetDir: './lib/javascripts'
          install: true
          verbose: false
          layout: 'byComponent'
          cleanTagetDir: true
          cleanBowerDir: false
    regarde:
      js:
        files: ['javascripts/*.js']
        tasks: ['uglify']
      coffee:
        files: ['coffee/*.coffee']
        tasks: ['coffee', 'uglify']
      css:
        files: ['css/*.css']
        tasks: ['csslint', 'concat', 'cssmin']
      sass:
        files: ['sass/*.sass']
        tasks: ['sass', 'csslint', 'concat', 'cssmin']
 

  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-csslint'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-regarde'

  grunt.registerTask 'default', ['clean', 'bower:install', 'sass', 'csslint', 'concat', 'cssmin', 'coffee', 'uglify', 'regarde']
