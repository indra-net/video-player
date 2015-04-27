$ = require 'jquery'

postData = (server, data) ->
	$.ajax({
		type: 'POST'
		url: server
		data: JSON.stringify(data)
		contentType: 'application/json; charset=utf-8'
		dataType: 'application/json'
		success: () -> console.log 'ok'
		})


module.exports = (ev, eventServer) -> postData(eventServer, ev)