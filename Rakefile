$:.unshift File.dirname(__FILE__) + 'lib'
require "bundler/gem_tasks"

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new
task :default => :spec

desc "Ejecutar las espectativas de la clase Matriz"
task :local do
  sh "rspec --format documentation -Ilib -Ispec spec/matriz_sf_spec.rb"
end
