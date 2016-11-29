$:.push File.expand_path('../lib', __FILE__)

require 'json2properties'

Gem::Specification.new do |s|
  s.name        = 'json2properties'
  s.version     = Json2properties::VERSION
  s.summary     = 'Simple converted from JSON to Java properties'
  s.authors     = ['Bartek Wilczek']
  s.email       = ['bwilczek@gmail.com']
  s.files       = Dir['lib/*.rb'] + Dir['lib/**/*.rb'] + Dir['bin/*']
  s.homepage    = 'https://github.com/bwilczek/json2properties'
  s.license     = 'MIT'
  s.executables = [ 'json2properties', 'properties2json' ]
  s.required_ruby_version = '~> 2.0'
  s.add_dependency 'java-properties', '~> 0.2'
  s.add_dependency 'activesupport', '~> 3.0'
end
