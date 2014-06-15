class TypeWorks
  constructor: () ->
    @panel = $('<div></div>').attr(id: 'typeworks')
    @panel.appendTo(document.body)

initialize = ->
  return if window.typeWorks
  window.typeWorks = new TypeWorks()
  return

if window.jQuery
  initialize()
else
  script = document.createElement('script')
  script.setAttribute('src', '//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js')
  document.body.appendChild(script)

  if script.readyState
    script.onreadystatechange = ->
      return unless @readyState == 'complete' || @readyState == 'loaded'
      initialize()
      return

  else
    script.onload = ->
      initialize()
      return
