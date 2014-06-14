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

    watch:
      coffee:
        files: '<%= app.javascripts %>/*.coffee'
        tasks: [ 'coffee:dev' ]

      sass:
        files: '<%= app.stylesheets %>/*.scss'
        tasks: [ 'sass:dev' ]

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-sass')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.registerTask('default', [ 'sass', 'coffee', 'watch' ])
