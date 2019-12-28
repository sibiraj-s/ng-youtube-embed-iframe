'use strict'

dartSass = require('sass')

banner = '/*!\n * @module <%= pkg.name %>\n' +
  ' * @description <%= pkg.description %>\n' +
  ' * @version v<%= pkg.version %>\n' +
  ' * @link <%= pkg.homepage %>\n' +
  ' * @licence MIT License, https://opensource.org/licenses/MIT\n' +
  ' */\n\n';

module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    coffeelintr:
      options:
        configFile: 'coffeelint.json'
      source: ['src/ng-youtube.coffee', 'Gruntfile.coffee']

    coffee:
      coffee2Js:
        options:
          join: true
        files:
          'dist/ng-youtube.js': ['src/ng-youtube.coffee']

    sass:
      options:
        implementation: dartSass
        sourcemap: 'none'
        style: 'expanded'
      scss2css:
        files:
          'docs/style.css': 'docs/style.scss'

    concat:
      options:
        stripBanners: true
        banner: banner
      jsConcat:
        files:
          'dist/ng-youtube.js': ['dist/ng-youtube.js']

    uglify:
      options:
        sourceMap: true
        output:
          comments: '/^!/'
      minifyJs:
        files:
          'dist/ng-youtube.min.js': ['dist/ng-youtube.js']

    clean:
      outDir:
        src: 'dist/'

    copy:
      default:
        expand: true
        src: ['LICENSE', 'README.md', 'CHANGELOG.md']
        dest: 'dist/'
      pkgJson:
        expand: true
        src: 'package.json'
        dest: 'dist/',
        options:
          process: (data) ->
            pkg = JSON.parse(data)
            pkg.main = 'ng-youtube.min.js'
            delete pkg.scripts
            delete pkg.devDependencies
            delete pkg.private
            delete pkg.engines
            JSON.stringify pkg, null, 2

    connect:
      server:
        options:
          base: './'
          hostname: 'localhost'
          open: true
          keepalive: true,
          livereload: true

    watch:
      coffee:
        files: ['src/*.coffee']
        tasks: ['coffee']
      js:
        files: ['docs/*.js', 'dist/*.js']
        options:
          livereload: true
      sass:
        files: ['docs/*.scss']
        tasks: ['sass']
      css:
        files: ['docs/*.css'],
        options:
          livereload: true
      html:
        files: ['docs/*.html']
        options:
          livereload: true

  # Grunt task(s).
  grunt.registerTask 'default', ['coffeelintr', 'coffee', 'sass']
  grunt.registerTask 'serve', ['sass', 'connect']
  grunt.registerTask 'develop', ['default', 'watch']
  grunt.registerTask 'build', ['clean', 'default', 'concat', 'uglify', 'copy']

  return
