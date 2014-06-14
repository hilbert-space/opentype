require 'sprockets'

class Application
  def initialize
    Sprockets.register_engine('.haml', Tilt::HamlTemplate)
    @sprockets = Sprockets::Environment.new
    @sprockets.append_path('app/assets/javascripts')
    @sprockets.append_path('app/assets/stylesheets')
    @sprockets.append_path('app/views/layouts')
    @sprockets.js_compressor = :uglify
    @sprockets.css_compressor = :scss
  end

  def call(env)
    case env['PATH_INFO']
    when /^.+(js|css)$/
      @sprockets.call(env)
    else
      [ 200, {}, [ @sprockets['application.html'].to_s ] ]
    end
  end
end

run Application.new
