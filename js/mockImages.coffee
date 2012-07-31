makeMockImages = () ->
  for img in $("img[width][height]")
    height = $(img).attr("height")
    width = $(img).attr("width")
    canvas =  document.createElement "canvas"
    canvas.setAttribute('width', width)
    canvas.setAttribute('height', height)
    context = canvas.getContext "2d"
    if color = $(img).attr "data-color"
      context.fillStyle = color
    else
      context.fillStyle = "rgba(0, 0, " + parseInt(55+Math.random()*200) + ", 0.5)"
      console.log context.fillStyle
    context.fillRect(0,0,width,height)
    context.textBaseline = "middle"
    context.fillStyle = "#fff"
    size = Math.min(height,width)/5
    context.font = "normal " + size + "px helvetica"
    context.textAlign = "center"
    info = width + "x" + height
    if text = $(img).attr "data-text"
      context.fillText(info, width/2, height/2 - size/2)
      if ( info_w = context.measureText( text ).width ) > width
        new_size = size*width/info_w
        context.font = "normal " + new_size * 0.95 + "px helvetica"
      context.fillText(text, width/2, height/2 + size/2)
    else
      context.fillText(info, width/2, height/2)
    $(img).attr src: canvas.toDataURL()
