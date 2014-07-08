class OpenType
  # Reference:
  # http://www.microsoft.com/typography/otspec/featuretags.htm
  @features = [
    { slug: 'kern', title: 'Kerning' },

    { slug: 'liga', title: 'Standard ligatures' },
    { slug: 'dlig', title: 'Discretionary ligatures' },
    { slug: 'hlig', title: 'Historical ligatures' },
    { slug: 'clig', title: 'Contextual ligatures' },

    { slug: 'smcp', title: 'Small capitals' },
    { slug: 'c2sc', title: 'Small capitals from capitals' },

    { slug: 'lnum', title: 'Lining figures', exclude: [ 'onum' ] },
    { slug: 'onum', title: 'Old-style figures', exclude: [ 'lnum' ] },

    { slug: 'pnum', title: 'Proportional figures', exclude: [ 'tnum' ] },
    { slug: 'tnum', title: 'Tabular figures', exclude: [ 'pnum' ] },

    { slug: 'frac', title: 'Fractions', exclude: [ 'afrc' ] },
    { slug: 'afrc', title: 'Alternative fractions', exclude: [ 'frac' ] },

    { slug: 'zero', title: 'Slashed zero' },
    { slug: 'nalt', title: 'Alternate annotation forms' },

    { slug: 'swsh', title: 'Swash' },
    { slug: 'calt', title: 'Contextual alternates' },
    { slug: 'hist', title: 'Historical forms' },
    { slug: 'salt', title: 'Stylistic alternates' },

    { slug: 'ss01', title: 'Stylistic set 1' },
    { slug: 'ss02', title: 'Stylistic set 2' },
    { slug: 'ss03', title: 'Stylistic set 3' },
    { slug: 'ss04', title: 'Stylistic set 4' }
  ]

  constructor: () ->
    return unless @$ = window.jQuery

    @features = {}
    @activeFeatures = []

    @target = @$('body')
    @target.addClass('opentype-target')

    @panel = @$('<div></div>').attr(id: 'opentype-panel')

    for feature in OpenType.features
      @features[feature.slug] = feature

      @$("<a><span>#{ feature.title }</span></a>").
        attr(href: '#', title: feature.title, 'data-feature': feature.slug).
        addClass('toggle').
        appendTo(@panel)

    @$('.toggle', @panel).click (e) =>
      element = @$(e.target)
      @toggle(element.data('feature'))
      element.toggleClass('active')
      false

    @panel.appendTo(document.body)

    @style = @$('<style></style>')
    @style.appendTo(document.head)

    @update()

  destroy: () ->
    @target.removeClass('opentype-target')
    @panel.remove()
    @style.remove()

    return

  toggle: (feature) ->
    index = @activeFeatures.indexOf(feature)
    if index > -1
      @activeFeatures.splice(index, 1)
    else
      @activate(feature)

    @update()

    return

  activate: (feature) ->
    @activeFeatures.push(feature)

    return unless @features[feature].exclude

    for another in @features[feature].exclude
      index = @activeFeatures.indexOf(another)
      continue unless index > -1

      @activeFeatures.splice(index, 1)
      @$(".toggle[data-feature=#{ another }]", @panel).removeClass('active')

    return

  update: () ->
    settings = "#{ @combine() } !important"
    @style.text """
      * {
        -moz-font-feature-settings: #{ settings };
        -ms-font-feature-settings: #{ settings };
        -o-font-feature-settings: #{ settings };
        -webkit-font-feature-settings: #{ settings };
        font-feature-settings: #{ settings };
      }
      """

    return

  combine: () ->
    line = ''

    for feature in @activeFeatures
      line += ',' if line.length
      line += '"' + feature + '" 1'

    if line.length then line else 'normal'

window.initializeOpenType = ->
  window.openType = new OpenType()
  return

window.deinitializeOpenType = ->
  window.openType.destroy()
  delete window.openType
  return

window.toggleOpenType = ->
  if window.openType
    window.deinitializeOpenType()
  else
    window.initializeOpenType()
  return

if window.jQuery
  window.initializeOpenType()
else
  script = document.createElement('script')

  if script.readyState
    script.onreadystatechange = ->
      return unless @readyState == 'complete' || @readyState == 'loaded'
      window.initializeOpenType()
      return
  else
    script.onload = ->
      window.initializeOpenType()
      return

  script.setAttribute('src', '//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js')
  document.body.appendChild(script)
