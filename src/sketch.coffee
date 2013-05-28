sketch = (p)->
	p.setup = ->
		# sketch setup
		p.size $(window).width(), $(window).height()
		p.background 0

		# esto es solo pa aprovechar la pantalla
		w = 37
		h = 19
		sw = ($(window).width()  - 2) / w
		sh = ($(window).height() - 2) / h
		p.world_scale = Math.floor (Math.min sw, sh)

		# environment setup
		@grid = new Grid p, w, h
		@robot = new Robot p, Math.random()*w, Math.random()*h, Math.PI/4
		@algorithm = new Algorithm @robot

	p.draw = ->
		p.translate 1, 1 # un pequeño margen pa que no se vea feo
		p.background 0

		@grid.draw()
		@robot.draw()

		framedrop = 5
		for i in [0..framedrop]
			sensors = @grid.sense @robot.sensor_positions()
			@algorithm.update(sensors)
		
