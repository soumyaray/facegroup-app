# frozen_string_literal: true
require 'rake/testtask'

task :run do
  sh 'rerun "rackup -p 9000"'
end

Rake::TestTask.new(:spec) do |t|
  t.pattern = 'spec/*_spec.rb'
  t.warning = false
end
