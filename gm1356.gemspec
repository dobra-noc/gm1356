# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name           = 'gm1356'
  s.version        = '0.0.2'
  s.date           = '2019-05-31'
  s.summary        = 'Captures and prints data, supports editing settings.'
  s.description    = 'Digital Sound Level Meter Gm1356 USB driver for Linux.'
  s.authors        = ['Maciej Ciemborowicz']
  s.email          = 'maciej.ciemborowicz+rubygems@gmail.com'
  s.files          = Dir['{lib}/**/*.rb', 'bin/*', '*.md']
  s.require_path   = 'lib'
  s.executables    = ['gm1356']
  s.homepage       = 'https://github.com/ciembor/gm1356'
  s.license        = 'MIT'
  s.add_dependency 'hidapi', '= 0.1.9'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'pry'
end
