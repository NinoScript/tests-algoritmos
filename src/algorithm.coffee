class Algorithm
	constructor: (@robot) ->

	update: (sensors)->
		if not sensors[2]
			@robot.rotate(0.05)
		else
			if sensors[0]
				@robot.rotate(-0.07)
			@robot.move(0.03)
