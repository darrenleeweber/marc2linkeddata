# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'marc2linkeddata'
  s.version     = '0.0.1'

  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Darren Weber',]
  s.email       = ['dlweber@stanford.edu']
  s.summary     = 'Convert Marc21 records to linked data, for use in SUL/DLSS projects'
  s.description = 'A SUL script to facilitate translation of Marc21 records to linked open data'

  s.required_rubygems_version = '>= 1.3.6'
  s.required_ruby_version = '>= 2.1.0'

  s.add_dependency 'marc'
  s.add_dependency 'linkeddata'

  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-doc'

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
end
