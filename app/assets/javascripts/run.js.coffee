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
    @panel = $('<div></div>').attr(id: 'typeworks-panel')

    for feature in TypeWorks.features
      $('<a></a>').
        attr(href: '#', title: feature).
        addClass('toggle').
        data(feature: feature).
        appendTo(@panel)

    $('.toggle', @panel).on 'click', (e) =>
      element = $(e.target)
      @toggle(element.data('feature'))
      element.toggleClass('active')

    @panel.appendTo(document.body)
    @activeFeatures = []

  toggle: (feature) ->
    index = @activeFeatures.indexOf(feature)
    if index > -1
      @activeFeatures.splice(index, 1)
    else
      @activeFeatures.push(feature)

    @update('body')

    return

  update: (selector) ->
    element = $(selector)
    return unless element.length

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
