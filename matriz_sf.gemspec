# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'matriz_sf/version'

Gem::Specification.new do |spec|
  spec.name          = "matriz_sf"
  spec.version       = MatrizSf::VERSION
  spec.authors       = ["Fabio Mendoza Bello & Sebastian Ospina Berrio"]
  spec.email         = ["alu0100463910@ull.edu.es"]
  spec.description   = %q{Desarrollada por Fabio Mendoza y Sebastian Ospina}
  spec.summary       = %q{Practica 10 de LPP}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec', '~> 2.9'
end
