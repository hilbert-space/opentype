require 'bundler'
Bundler.require(:default)

module TypeExpert
  class Application < Rail::Application
    config.precompile << 'application.css'
    config.precompile << 'index.html'
    config.precompile << 'run.css'
    config.precompile << 'run.js'
  end
end
