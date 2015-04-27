$ = require 'jquery'
_ = require 'lodash'
Bacon = require 'baconjs'

injectEvent = require './injectEvent.coffee'

isTruthy = (item) -> if item then item 
nonEmpty = (array) -> array.length>0
isNumberClose = (number1, number2, threshold) ->
	if Math.abs(number1-number2) < threshold then true else false
# convert video time to ms
getVideoTime = (videoEl) -> videoEl.currentTime*1000
eventLi = (videoEvent) -> 
	_.template('<li> <%= videoEvent.time %> : <%= videoEvent.eventName %>')(videoEvent:videoEvent)

exports.setup = (events, synchronisedTimeProperty, eventServerURL) ->

	# interface elemnts
	video = document.getElementById("video")
	playButton = document.getElementById("playButton")
	$triggeredEvents = $("#triggeredEvents")
	# num of ms to check for events
	pollVideoTimeInterval = 100

	# turn all the events into a list of their timestamps
	timestamps = _.keys(events)
	timestamps = _.map(timestamps, (key) -> Number(key))
	# the next time cue for us to watch out for
	nextTimestamp = _.first(timestamps)

	playClicks = Bacon.fromEvent(playButton, 'click')
	# when we click play
	playClicks.onValue(()->
		# start video
		video.play()
		# start an interval for checking the events
		triggeredEventsStream = Bacon.fromPoll(
			pollVideoTimeInterval, () ->
				timeInVideo = getVideoTime(video)
				if isNumberClose(nextTimestamp, timeInVideo, pollVideoTimeInterval)
					thisTimestamp = nextTimestamp
					timestamps = _.rest(timestamps)
					nextTimestamp = _.first(timestamps)
					# return the event
					return events[thisTimestamp])
			.skipDuplicates()
			.filter(isTruthy)

		indraEventsStream = Bacon.combineTemplate({
			eventName: triggeredEventsStream
			time: synchronisedTimeProperty
		}).sampledBy(triggeredEventsStream)
	
		# add video events to the DOM (FIFO style) 
		indraEventsStream
			.onValue((videoEvent) -> 
				$triggeredEvents.prepend(eventLi(videoEvent))
				injectEvent(videoEvent, eventServerURL)))



		


