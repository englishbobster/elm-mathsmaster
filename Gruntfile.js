module.exports = function(grunt) {

  grunt.initConfig({
    elm: {
      compile: {
        files: {
          "Main.js": ["Main.elm"]
        }
      }
    },
    watch: {
      elm: {
                files: ["Main.elm",
                        "QuizGen.elm",
                        "Models.elm",
                        "Messages.elm",
                        "Update.elm"],
        tasks: ["elm"]
      }
    },
    clean: ["elm-stuff/build-artifacts"]
  });

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-elm');

  grunt.registerTask('default', ['elm']);

};
