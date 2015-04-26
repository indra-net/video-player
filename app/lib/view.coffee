$ = require 'jquery'
_ = require 'lodash'
Kefir = require 'kefir'
float = require 'float'

nonEmpty = (array) -> array.length>0
# convert video time to ms
getVideoTime = (videoEl) -> videoEl.currentTime*1000

isNumberClose = (number1, number2, threshold) ->
	if Math.abs(number1-number2) < threshold then true else false

exports.setup = (events) ->

	# interface elemnts
	video = document.getElementById("video")
	playButton = document.getElementById("playButton")
	# num of ms to check for events
	pollInterval = 100

	# turn all the events into a list of their timestamps
	timestamps = _.keys(events)
	timestamps = _.map(timestamps, (key) -> Number(key))
	# the next time cue for us to watch out for
	nextTimestamp = _.first(timestamps)

	console.log 'timestamps', timestamps

	playClicks = Kefir.fromEvents( playButton, 'click')
	# when we click play
	playClicks.onValue(()->
		# start video
		video.play()
		# start an interval for checking the events
		triggeredEventsStream = Kefir.fromPoll(
			pollInterval
			, (events) -> 
				timeInVideo = getVideoTime(video)
				if isNumberClose(nextTimestamp, timeInVideo, pollInterval)
					thisTimestamp = nextTimestamp
					timestamps = _.rest(timestamps)
					nextTimestamp = _.first(timestamps)
					return thisTimestamp
				)


		# log triggered events
		triggeredEventsStream.skipDuplicates().log() )

