# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "magency_api/version"

Gem::Specification.new do |s|
  s.name        = "MagencyAPI"
  s.version     = MagencyAPI::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Lex Antonov"]
  s.email       = ["lex.antonov@gmail.com"]
  s.homepage    = "https://github.com/"
  s.summary     = %q{Гем для взаимодействия с api mskagency}
  s.description = %q{Гем для взаимодействия с api mskagency.ru}

  s.rubyforge_project = "MagencyAPI"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_dependency('activesupport')
end