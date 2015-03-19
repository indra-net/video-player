module.exports = (grunt) ->

	grunt.initConfig

		coffeeify: 
			compile: 
				options: {},
				files: [{
					src: ['app/lib/*.coffee', 'app/main.coffee'],
					dest: 'dist/bundle.js'
	      		}]
		jade:
			compile:
				options:
					data:
						debug: false
				files: 
					'dist/index.html':['app/index.jade']
		watch:
			jade:
				files: ['app/index.jade']
				tasks: ['jade:compile']
			coffeeify:
				files: ['app/lib/*.coffee', 'app/main.coffee']
				tasks: ['coffeeify:compile']
					
	grunt.loadNpmTasks 'grunt-coffeeify'
	grunt.loadNpmTasks 'grunt-contrib-jade'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.registerTask 'default', ['coffeeify', 'jade']
