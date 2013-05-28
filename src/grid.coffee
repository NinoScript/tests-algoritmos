class Grid
	constructor: (@p, @WIDTH, @HEIGHT)->
		#random map
		@mapa = []
		for j in [0...@HEIGHT]
			@mapa[j] = []
			for i in [0...@WIDTH]
				@mapa[j][i] = Math.floor(Math.random() * 2)
	draw: ->
		s = p.world_scale
		@p.stroke 200
		for j in [0...@HEIGHT]
			for i in [0...@WIDTH]
				@p.fill 30 + 50*@mapa[j][i]
				@p.rect i*s, j*s, s, s
	sense: (sensor_positions)->
		# console.log @mapa
		sensor_positions.map (s)=>
			y = Math.floor s.y
			x = Math.floor s.x
			if 0<=x<@WIDTH and 0<=y<@HEIGHT
				@mapa[y][x]
			else
				0 # afuera de la cuadrilla hay abismo
