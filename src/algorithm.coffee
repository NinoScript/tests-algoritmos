class Algorithm
  constructor: (@p, opts) ->
    @x = opts.x
    @y = opts.y

    @x_off = opts.x_off
    @y_off = opts.y_off

    @vel = opts.vel || 3
    @accel = opts.accel || -0.003

  draw: () ->
    return unless @vel > 0

    @x_off += 0.0007
    @y_off += 0.0007

    @vel += @accel

    @x += @p.noise(@x_off) * @vel - @vel/2
    @y += @p.noise(@y_off) * @vel - @vel/2

    @set_color()
    @p.point(@x, @y)


  set_color: () ->
    @p.colorMode(@p.HSB, 360, 100, 100)

    h = @p.noise((@x_off+@y_off)/2)*360
    s = 100
    b = 100
    a = 4

    @p.stroke(h, s, b, a)
