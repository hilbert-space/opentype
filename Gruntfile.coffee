module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    app:
      assets: 'app/assets'
      stylesheets: '<%= app.assets %>/stylesheets'
      javascripts: '<%= app.assets %>/javascripts'

    sass:
      dev:
        files: [
          expand: true
          cwd: '<%= app.stylesheets %>'
          src: [ '*.scss' ]
          dest: 'public'
          ext: '.css'
        ]

    coffee:
      dev:
        files: [
          expand: true
          cwd: '<%= app.javascripts %>'
          src: [ '*.coffee' ]
          dest: 'public'
          ext: '.js'
        ]

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-sass')

  grunt.registerTask('default', [ 'sass', 'coffee' ])
