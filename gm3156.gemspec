# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name           = 'gm3156'
  s.version        = '0.0.1'
  s.date           = '2019-05-31'
  s.summary        = 'Captures and prints data, supports editing settings.'
  s.description    = 'Digital Sound Level Meter Gm1356 USB driver for Linux.'
  s.authors        = ['Maciej Ciemborowicz']
  s.email          = 'maciej.ciemborowicz+rubygems@gmail.com'
  s.files          = Dir['{lib}/**/*.rb', 'bin/*', '*.md']
  s.require_path   = 'lib'
  s.executables    = ['gm3156']
  s.homepage       = 'https://github.com/ciembor/gm1356'
  s.license        = 'MIT'
  s.add_dependency 'hidapi', '= 0.1.9'
end
