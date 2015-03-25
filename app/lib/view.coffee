$ = require('jquery')

exports.setup = () ->
	$('body').append('<p>hi from view</p>')
	$('body').append('<img src="assets/wand.gif">')