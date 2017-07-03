'use strict'

module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)

  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")

    coffeelint:
      options:
        configFile: 'coffeelint.json'
      source: ['src/ng-youtube.coffee']

    coffee:
      compileJoined:
        options:
          join: true
        files:
          'dist/ng-youtube.js': ['src/ng-youtube.coffee']

    watch:
      files: ['src/*.coffee']
      tasks: ['default']

    uglify:
      options:
        sourceMap: true
      target:
        files:
          'dist/ng-youtube.min.js': ['dist/ng-youtube.js']

    ngAnnotate:
      options:
        singleQuotes: true

      ngYoutube:
        files:
          'dist/ng-youtube.js': ['dist/ng-youtube.js']

    connect:
      server:
        options:
          base: './'
          keepalive: true


  # Grunt task(s).
  grunt.registerTask "default", ["coffeelint", "coffee"]
  grunt.registerTask "webserver", ["connect"]
  grunt.registerTask "develop", ["default", "watch"]
  grunt.registerTask "dist", ["default", "ngAnnotate", "uglify"]

  return
