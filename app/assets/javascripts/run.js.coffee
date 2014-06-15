class TypeWorks
  @features = [
    'kern',
    'liga', 'dlig', 'hlig', 'clig',
    'smcp', 'c2sc',
    'lnum', 'onum',
    'pnum', 'tnum',
    'frac', 'afrc',
    'zero', 'nalt',
    'swsh', 'calt', 'hist', 'salt',
    'ss01', 'ss02', 'ss03', 'ss04', 'ss05'
  ]

  constructor: () ->
    @panel = $('<div></div>').attr(id: 'typeworks')

    for feature in TypeWorks.features
      $('<a></a>').
        attr(href: '#', title: feature, 'data-feature': feature).
        addClass('toggle').
        appendTo(@panel)

    $('.toggle', @panel).click (e) =>
      element = $(e.target)
      @toggle(element.data('feature'))
      element.toggleClass('active')
      false

    @panel.appendTo(document.body)
    @activeFeatures = []

  destroy: () ->
    @activeFeatures = []
    @update()

    @panel.remove()
    delete @panel

    return

  toggle: (feature) ->
    index = @activeFeatures.indexOf(feature)
    if index > -1
      @activeFeatures.splice(index, 1)
    else
      @activeFeatures.push(feature)

    @update()

    return

  update: (selector = 'body') ->
    element = $(selector)

    settings = @combine()
    element.css
      '-moz-font-feature-settings': settings
      '-ms-font-feature-settings': settings
      '-o-font-feature-settings': settings
      '-webkit-font-feature-settings': settings
      'font-feature-settings': settings

    settings = @combineAlternative()
    element.css
      '-moz-font-feature-settings': settings

    return

  combine: () ->
    line = ''

    for feature in @activeFeatures
      line += ',' if line.length
      line += '"' + feature + '" 1'

    line

  combineAlternative: () ->
    line = ''

    for feature in @activeFeatures
      line += ',' if line.length
      line += feature + '=1'

    '"' + line + '"'

window.initializeTypeWorks = ->
  window.typeWorks = new TypeWorks()
  return

window.deinitializeTypeWorks = ->
  window.typeWorks.destroy()
  delete window.typeWorks
  return

window.toggleTypeWorks = ->
  if window.typeWorks
    window.deinitializeTypeWorks()
  else
    window.initializeTypeWorks()
  return

if window.jQuery
  window.initializeTypeWorks()
else
  script = document.createElement('script')

  if script.readyState
    script.onreadystatechange = ->
      return unless @readyState == 'complete' || @readyState == 'loaded'
      window.initializeTypeWorks()
      return
  else
    script.onload = ->
      window.initializeTypeWorks()
      return

  script.setAttribute('src', '//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js')
  document.body.appendChild(script)
