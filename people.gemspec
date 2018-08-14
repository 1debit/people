# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-
require File.expand_path('../lib/people/version', __FILE__)

Gem::Specification.new do |s|
  s.name ='people'
  s.version = People::VERSION

  s.authors = ['Matthew Ericson']
  s.date = '2010-10-29'
  s.email = 'mericson@ericson.net'
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files         = `git ls-files`.split($\)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})

  s.homepage = 'http://github.com/mericson/people'
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = 'Matts Name Parser'

  s.add_development_dependency 'pry'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
end
