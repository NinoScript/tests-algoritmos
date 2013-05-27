class Algorithm
	constructor: (@robot) ->

	update: (sensors)->
		@robot.rotate(0.02)
		@robot.move(0.01)
