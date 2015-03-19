$ = require('jquery')
example_view = require './lib/view.coffee'

(()-> 
	$('body').append('<h1>hi from main.coffee</h1>')
	example_view.setup()
)()