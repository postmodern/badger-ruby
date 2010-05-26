require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:development, :doc)
rescue Bundler::BundlerError => e
  STDERR.puts e.message
  STDERR.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'
require 'jeweler'

Jeweler::Tasks.new do |gem|
  gem.name = 'badger-ruby'
  gem.licenses = ['MIT']
  gem.summary = %Q{A Badger client for Ruby.}
  gem.description = %Q{A client for Badger written in Ruby using ffi-msgpack and ffi-rzmq.}
  gem.email = 'postmodern.mod3@gmail.com'
  gem.authors = ['Postmodern']
  gem.homepage = 'http://github.com/postmodern/ffi-msgpack'
  gem.has_rdoc = 'yard'
end

require 'spec/rake/spectask'

desc "Run all specifications"
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs += ['lib', 'spec']
  spec.spec_files = FileList['spec/**/*_spec.rb']
  spec.spec_opts = ['--options', '.specopts']
end
task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
