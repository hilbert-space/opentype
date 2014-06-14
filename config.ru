require 'haml'
require 'uglifier'
require 'sprockets'

require_relative 'app/helpers/common_helper'

Haml::Helpers.include(CommonHelper)
Tilt::CoffeeScriptTemplate.default_bare = true
Sprockets.register_engine('.haml', Tilt::HamlTemplate)

class Application
  def initialize
    @sprockets = Sprockets::Environment.new
    @sprockets.append_path('app/assets/javascripts')
    @sprockets.append_path('app/assets/stylesheets')
    @sprockets.append_path('app/views/layouts')
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
