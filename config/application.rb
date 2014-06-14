require 'haml'
require 'uglifier'
require 'sprockets'

require File.expand_path('../../app/helpers/common_helper', __FILE__)

Sprockets.register_engine('.haml', Tilt::HamlTemplate)

class Application
  def call(env)
    pipeline = build_pipeline(env)

    case env['PATH_INFO']
    when /^.+(js|css)$/
      pipeline.call(env)
    else
      [ 200, {}, [ pipeline['application.html'].to_s ] ]
    end
  end

  private

  def build_pipeline(env)
    pipeline = Sprockets::Environment.new

    pipeline.append_path('app/assets/javascripts')
    pipeline.append_path('app/assets/stylesheets')
    pipeline.append_path('app/views/layouts')

    pipeline.context_class.class_eval do
      include CommonHelper

      define_method(:server_address) do
        env['HTTP_HOST']
      end
    end

    pipeline
  end
end
