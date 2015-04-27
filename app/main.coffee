video_view = require './lib/view.coffee'
sank = require './lib/sank.coffee'
$ = require('jquery')
Bacon = require 'baconjs'


init = ->

	# config
	timeServerURL = 'http://indra.webfactional.com/timeserver'
	syncWithTimeServerInterval = 3000
	pollClockInterval = 100
	eventServerURL = 'http://indra.webfactional.com/eventserver'

	#
	#  to change the video , edit index.html
	#

	# events
	# format: timeInVideo:EventName
	events = {
		# blinks
		0: 'blinkInstruction'
		4500:'blink1'
		6000:'blink2'
		7500:'blink3'
		9000:'blink4'
		10500:'blink5'
		# relaxation
		12000:'relaxInstruction'
		17000:'relax'
		# math
		47000:'mathInstruction'
		52000:'math1'	
		54500:'math2'
		57000:'math3'	
		59500:'math4'	
		62000:'math5'	
		64500:'math6'
		67000:'math7'
		69500:'math8'
		72000:'math9'
		74500:'math10'
		77000:'math11'
		79500:'math12'
		# music
		82000:'musicInstruction'
		87000:'music'
		# watch video
		117000:'videoInstruction'
		122000:'video-ver2'
		# think of items
		152000: 'thinkOfItemsInstruction-ver2'
		172000: 'thinkOfItems-ver2'
		# colors intro
		202000: 'colorInstruction1'
		212000: 'colorInstruction2'
		# color round1 (4s)
		227000: 'readyRound1'
		230000: 'colorRound1-1'
		234000: 'colorRound1-2'
		238000: 'colorRound1-3'
		242000: 'colorRound1-4'
		246000: 'colorRound1-5'
		250000: 'colorRound1-6'
		# color round2 (3s)
		225400: 'readyRound2'
		257000: 'colorRound2-1'
		260000: 'colorRound2-2'
		263000: 'colorRound2-3'
		266000: 'colorRound2-4'
		269000: 'colorRound2-5'
		272000: 'colorRound2-6'
		# color round3 (2s)
		275000: 'readyRound3'
		278000: 'colorRound3-1'
		280000: 'colorRound3-2'
		282000: 'colorRound3-3'
		284000: 'colorRound3-4'
		286000: 'colorRound3-5'
		288000: 'colorRound3-6'
		# color rounud4 (1s)
		290000: 'readyRound4'
		293000: 'colorRound4-1'
		294000: 'colorRound4-2'
		295000: 'colorRound4-3'
		296000: 'colorRound4-4'
		297000: 'colorRound4-5'
		298000: 'colorRound4-6'
		# color round 5 (3s)
		299000: 'readyRound5'
		302000: 'colorRound5-1'
		305000: 'colorRound5-2'
		308000: 'colorRound5-3'
		311000: 'colorRound5-4'
		314000: 'colorRound5-5'
		317000: 'colorRound5-6'

	}

	$clock = $("#clock")

	# get a synchronised time
	synchronisedTimeProperty = 
		sank(timeServerURL, syncWithTimeServerInterval, pollClockInterval)
	# update clock
	synchronisedTimeProperty.onValue((time) -> $clock.html(time.format('MMMM Do YYYY, H:mm:ss:SSS')))

	# events are injected here
	video_view.setup(events, synchronisedTimeProperty, eventServerURL)

	console.log 'main app done+launched'

# launch the app
$(document).ready(() ->
	init() )
