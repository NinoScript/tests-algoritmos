p = null

$ ->
  canvas = $("#processing")[0]
  p = new Processing(canvas, sketch)
