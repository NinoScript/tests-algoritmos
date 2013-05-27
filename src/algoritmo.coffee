coffee_draw = (p) ->
  p.setup = () ->
    p.size($(window).width(), $(window).height())
    p.background(0)
    @beans = []

  p.draw = () ->
    x_off = p.frameCount * 0.0003
    y_off = x_off + 20

    x = p.noise(x_off) * p.width
    y = p.noise(y_off) * p.height

    if p.frameCount % 8 == 0
      bean = new Bean(p, {
        x: x
        y: y
        x_off: x_off
        y_off: y_off
      })
      @beans.push(bean)

    bean.draw() for bean in @beans

$ ->
  canvas = $("#processing")[0]
  processing = new Processing(canvas, coffee_draw)
