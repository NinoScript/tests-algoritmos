class Grid
	constructor: (@p)->
		@HEIGHT = 3
		@WIDTH  = 5
	draw: ->
		s = p.world_scale
		@p.stroke 200
		for j in [0...@HEIGHT]
			for i in [0...@WIDTH]
				@p.fill 50
				@p.rect i*s, j*s, s, s
	sense: (sensor_positions)->
		[]