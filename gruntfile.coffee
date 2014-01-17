module.exports = (grunt) ->
  grunt.initConfig

    nodemon:
      development:
        options:
          file: 'yoi.js'
          ignoredFiles: ['node_modules','assets']
          watchedExtensions: ['yml', 'coffee'],
          watchedFolders: ['yoi.yml', 'endpoints', 'environments']


  grunt.loadNpmTasks 'grunt-nodemon'

  # =======================================================
  # REGISTER
  # =======================================================
  grunt.registerTask "default", ["server"]
  grunt.registerTask "server", ["nodemon"]
