example_view = require './lib/view.coffee'

module.exports = App = 
	init: ->
		console.log 'main app launching'
		example_view.setup()
		console.log 'main app done+launched'
