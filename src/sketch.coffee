sketch = (p)->
	p.world_scale = 100
	p.setup = ->
		# sketch setup
		p.size $(window).width(), $(window).height()
		p.background 0

		# environment setup
		@grid = new Grid p
		@robot = new Robot p, 2.3, 0.8
		@algorithm = new Algorithm @robot

	p.draw = ->
		p.translate 1, 1 # un pequeño margen pa que no se vea feo
		p.background 0

		@grid.draw()
		@robot.draw()
		sensors = @grid.sense @robot.sensor_positions()
		@algorithm.update(sensors)
