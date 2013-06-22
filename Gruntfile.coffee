module.exports = (grunt) ->

  # Load Grunt tasks declared in the package.json file
  require("matchdep").filterDev("grunt-*").forEach grunt.loadNpmTasks

  # Configure Grunt

  # grunt-contrib-connect will serve the files of the project
  # on specified port and hostname
  grunt.initConfig
    connect:
      all:
        options:
          port: 9000
          hostname: "0.0.0.0"
          base: "build"

          # Prevents Grunt to close just after the task (starting the server) completes
          # This will be removed later as `watch` will take care of that
          # keepalive: true

          # Livereload needs connect to insert a cJavascript snippet
          # in the pages it serves. This requires using a custom connect middleware{}
          middleware: (connect, options) ->
            # Load the middleware provided by the livereload plugin
            # that will take care of inserting the snippet

            # Serve the project folder
            [
              require("grunt-contrib-livereload/lib/utils").livereloadSnippet,
              connect.static(options.base)
            ]

    open:
      all:
        # Gets the port from the connect configuration
        path: 'http://0.0.0.0:<%= connect.all.options.port%>'

    copy:
      dist:
        files: [
          # templates
          {
            expand: true
            cwd: "templates/"
            src: ["*.html"]
            dest: "build/"
            filter: 'isFile'
          }
          {
            src: ["components/threejs/build/three.min.js"]
            dest: "build/javascripts/lib/three.min.js"
          }
          {
            src: ["components/underscore/underscore-min.js"]
            dest: "build/javascripts/lib/underscore.min.js"
          }
        ]

    watch:
      coffescripts:
        files: ["coffee/*.coffee"]
        tasks: ["coffee"]
        options:
          livereload: true
          nospawn: true
      stylesheets:
        files: ["sass/*.scss"]
        tasks: ["sass"]
        options:
          livereload: true
          nospawn: true
      static:
        # This'll just watch the index.html file, you could add **/*.js or **/*.css
        # to watch Javascript and CSS files too.
        files:['templates/*.html']
        # This configures the task that will run when the file change
        tasks: ["copy"]
        options:
          livereload: true
          nospawn: true

    sass:
      all:
        options:
          style: "compressed"
        files:
          "build/stylesheets/app.css": "sass/app.scss"
        yuicompress: true
        compress: true

    coffee:
      glob_to_multiple:
        expand: true
        flatten: true
        cwd: 'coffee'
        src: ['*.coffee']
        dest: 'build/javascripts'
        ext: '.js'

    concat:
      scripts:
        src: [
          'build/javascripts/lib/three.min.js'
          'build/javascripts/lib/underscore.min.js'
          'build/javascripts/app.js'
        ]
        dest: 'build/javascripts/built.js'

  # Creates the `server` task
  grunt.registerTask "server", ["connect", "watch"]