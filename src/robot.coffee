class Robot
	constructor: (@p, x=0, y=0, theta=0)->
		@pos = new Vector x, y
		@dir = new Vector 1, 0
		# @dir.rotateZ(theta)
		
	draw: ()->
		from = @pos.get()
		from.mult(p.world_scale)

		to = @dir.get()
		to.mult(10)
		to.add(from)

		@p.stroke 255
		@p.line from.x, from.y, to.x, to.y

	move: (distance)->
		movement = @dir.get()
		movement.mult(distance)
		@pos.add movement

	rotate: (theta)->
		@dir.rotateZ theta

	sensor_positions: ()->
		[]
