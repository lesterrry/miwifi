# Handcrafted by Aydar N.
# 2023
#
# me@aydar.media
#

# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
	t.libs << 'test'
	t.libs << 'lib'
	t.test_files = FileList['test/**/*_test.rb'].exclude('test/**/*_bench_test.rb')
end

desc 'Run all tests'
task default: :test
