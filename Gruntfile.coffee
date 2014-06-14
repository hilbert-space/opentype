module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    app:
      views: 'app/views'
      layouts: '<%= app.views %>/layouts'

      assets: 'app/assets'
      stylesheets: '<%= app.assets %>/stylesheets'
      javascripts: '<%= app.assets %>/javascripts'

    coffee:
      dist:
        files: [
          expand: true
          cwd: '<%= app.javascripts %>'
          src: [ '*.coffee' ]
          dest: 'public'
          ext: '.js'
        ]

    haml:
      dist:
        files:
          'public/index.html': '<%= app.layouts %>/application.html.haml'

    sass:
      dist:
        files: [
          expand: true
          cwd: '<%= app.stylesheets %>'
          src: [ '*.scss' ]
          dest: 'public'
          ext: '.css'
        ]

    watch:
      coffee:
        files: '<%= app.javascripts %>/*.coffee'
        tasks: [ 'coffee:dist', 'haml:dist' ]

      haml:
        files: '<%= app.layouts %>/*.haml'
        tasks: [ 'haml:dist' ]

      sass:
        files: '<%= app.stylesheets %>/*.scss'
        tasks: [ 'sass:dist', 'haml:dist' ]

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-haml')
  grunt.loadNpmTasks('grunt-contrib-sass')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.registerTask('build', [ 'coffee', 'haml', 'sass' ])
  grunt.registerTask('default', [ 'build', 'watch' ])
