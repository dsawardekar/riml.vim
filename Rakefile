require 'rake/clean'
require 'find'
require_relative 'lib/tasks/utils'
require_relative 'lib/tasks/paths'

desc 'Default task :test'
task :default => :test

desc 'Build files and folders'
task :build do
  verbose VERBOSE do
    mkdir_p BUILD_DIR
  end
end

desc 'Compile compiler'
task :compile_compiler => :build do
  sh "bundle exec riml -c #{COMPILER_SOURCE} -I #{LIB_DIRS} -o #{COMPILER_OUTPUT_DIR}"
end

desc 'Compile all'
task :compile => [:compile_compiler]

desc 'Run all tests'
task :test => [:build] do
  sh "bundle exec speckle -a #{TEST_DIR} -I #{SPECKLE_LIB_DIRS}"
end

desc 'Move compiled files into vim directories'
task :dist => [:compile] do
  move_to COMPILER_OUTPUT, COMPILER_DEST
end

