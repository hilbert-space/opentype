task :default => :server

task :server do
  exec('bundle exec thin start')
end

namespace :assets do
  desc 'Precompile static files'
  task :precompile do
    ENV['production'] = '1'

    require 'rack'
    require File.expand_path('../config/application', __FILE__)

    application = Application.new

    { '/' => 'index.html',
      '/run.js' => 'run.js',
      '/run.css' => 'run.css',
      '/application.css' => 'application.css'
    }.each do |path, file|
      env = { 'HTTP_HOST' => 'type.works', 'PATH_INFO' => path }
      _, _, source = application.call(env)
      File.open(File.join('public', file), 'w') { |f| f.write(source.to_s) }
    end
  end
end
