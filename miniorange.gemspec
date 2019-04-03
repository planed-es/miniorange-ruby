# -*- encoding: utf-8 -*-
# frozen_string_literal: true

$:.push File.expand_path("../lib", __FILE__)
require "miniorange/version"

Gem::Specification.new do |s|
  s.name        = "miniorange"
  s.version     = MiniOrange::VERSION.dup
  s.platform    = Gem::Platform::RUBY
  s.licenses    = ["MIT"]
  s.summary     = "Client for MiniOrange service"
  s.email       = "contact@planed.es"
  s.homepage    = "https://bitbucket.org/planed/miniorange-ruby"
  s.description = "Client for MiniOrange service"
  s.authors     = ['Michaël Martín Moro']

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.require_paths = ["lib"]
  s.required_ruby_version = '>= 2.1.0'
end

