require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end

require 'rake'
require 'jeweler'
require './lib/mocapi.rb'

Jeweler::Tasks.new do |gem|
  gem.name = 'mocapi'
  gem.required_ruby_version = "~> #{IO.read '.ruby_version'}"
  gem.homepage = 'http://github.com/sangster/mocapi'
  gem.license = 'MIT'
  gem.summary = %(A simple mortage calculator JSON API server)
  gem.description = %(A simple mortage calculator JSON API server)
  gem.email = 'jon@ertt.ca'
  gem.authors = ['Jon Sangster']
  gem.version = Mocapi::Version::STRING
  gem.executables = %w[mocapi]
end
Jeweler::RubygemsDotOrgTasks.new

Rake::Task[:console].clear
task :console do
  $LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
  require 'pry'
  Pry.start
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

desc 'Code coverage detail'
task :simplecov do
  ENV['COVERAGE'] = 'true'
  Rake::Task['test'].execute
end

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ''

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "mocapi #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'yard'
YARD::Rake::YardocTask.new do |t|
  t.files = ['lib/**/*.rb']
end

require 'rubocop/rake_task'
RuboCop::RakeTask.new

desc 'Run all linters'
task lint: [:rubocop]

desc 'Run all tests and linters'
task check: %i[test rubocop simplecov]

task default: :check
