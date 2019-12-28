dartSass = require('sass')
loadGruntTasks = require('load-grunt-tasks')

banner = '/*!\n * @module <%= pkg.name %>\n' +
  ' * @description <%= pkg.description %>\n' +
  ' * @version v<%= pkg.version %>\n' +
  ' * @link <%= pkg.homepage %>\n' +
  ' * @licence MIT License, https://opensource.org/licenses/MIT\n' +
  ' */\n\n';

module.exports = (grunt) ->
  loadGruntTasks(grunt)

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

    browserSync:
      bsFiles:
        src: [
          'docs/*.css',
          'docs/**/*.html',
          'docs/*.js',
          'dist/*.js'
          ]
      options:
        watchTask: true
        open: false
        server:
          baseDir: 'docs'
          routes:
            '/dist': 'dist'
        rewriteRules: [{
          match: '//cdn.jsdelivr.net/npm/ng-youtube-embed-iframe@latest/ng-youtube.min.js',
          replace: '/dist/ng-youtube.js',
        }]

    watch:
      coffee:
        files: ['src/*.coffee']
        tasks: ['coffee']
      sass:
        files: ['docs/*.scss']
        tasks: ['sass']

  # Grunt task(s).
  grunt.registerTask 'default', ['coffee']
  grunt.registerTask 'serve', ['default', 'browserSync', 'watch']
  grunt.registerTask 'build', ['clean', 'default', 'concat', 'uglify', 'copy']

  return
