# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dottor/version"

Gem::Specification.new do |s|
  s.name        = "dottor"
  s.version     = Dottor::VERSION
  s.authors     = ["Marco Campana"]
  s.email       = ["m.campana@gmail.com"]
  s.homepage    = 'http://github.com/marcocampana/dottor'
  s.summary     = %q{Command line tool to manage dotfile the easy way}
  s.description = %q{Command line tool for easily managing your dotfiles, without assumptions on how your dotfiles repository should be organized.}

  s.rubyforge_project = "dottor"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'thor'
  s.add_development_dependency 'rspec'
end
