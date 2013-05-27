sketch = (p)->
	p.world_scale = Math.min $(window).width()/6, $(window).height()/4 #estoy hay que hacerlo con una matriz de transformación
	p.setup = ->
		# sketch setup
		p.size $(window).width(), $(window).height()
		p.background 0

		# environment setup
		@grid = new Grid p
		@robot = new Robot p, 2.3, 0.8
		@algorithm = new Algorithm @robot

	p.draw = ->
		p.background 0

		@grid.draw()
		@robot.draw()
		sensors = @grid.sense @robot.sensor_positions()
		@algorithm.update(sensors)
