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
            cwd: "src/templates/"
            src: ["*.html"]
            dest: "build/"
            filter: 'isFile'
          }
          {
            src: ["components/requirejs/require.js"]
            dest: "build/javascripts/lib/require.js"
          }
          {
            src: ["components/threejs/build/three.min.js"]
            dest: "build/javascripts/lib/three.min.js"
          }
          {
            src: ["node_modules/leapjs/leap.min.js"]
            dest: "build/javascripts/lib/leap.min.js"
          }
          {
            expand: true
            cwd: "assets/images/"
            src: ["*.png", "*.jpg"]
            dest: "build/images/"
            filter: 'isFile'
          }
        ]

    watch:
      coffescripts:
        files: ["src/coffee/*.coffee"]
        tasks: ["coffee"]
        options:
          livereload: true
          nospawn: true
      coffee_modules:
        files: ["src/coffee/modules/*.coffee"]
        tasks: ["coffee"]
        options:
          livereload: true
          nospawn: true
      stylesheets:
        files: ["src/sass/*.scss"]
        tasks: ["sass"]
        options:
          livereload: true
          nospawn: true
      static:
        # This'll just watch the index.html file, you could add **/*.js or **/*.css
        # to watch Javascript and CSS files too.
        files:['src/templates/*.html']
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
          "build/stylesheets/app.css": "src/sass/app.scss"
        yuicompress: true
        compress: true

    coffee:
      glob_to_multiple:
        options:
          bare: true
        expand: true
        flatten: true
        cwd: 'src/coffee/modules'
        src: ['*.coffee']
        dest: 'build/javascripts/modules'
        ext: '.js'
      compile:
        options:
          bare: true
          join: true
        files:[
          "build/javascripts/playground.js":  "src/coffee/playground.coffee"
          "build/javascripts/app.js":  "src/coffee/app.coffee"
          # "build/javascripts/modules.js": [ "src/coffee/modules/*.coffee" ]
        ]

  # Creates the `server` task
  grunt.registerTask "server", ["coffee","sass","copy", "connect", "watch"]

