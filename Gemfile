source 'http://rubygems.org'

group :runtime do
  gem 'digest-crc',	'~> 0.1.0', :git => 'git://github.com/postmodern/digest-crc.git'
  gem 'ffi-msgpack',	'~> 0.1.2'
  gem 'ffi-rzmq',	'~> 0.4.1', :git => 'git://github.com/chuckremes/ffi-rzmq.git'
end

group :development do
  gem 'bundler',	'~> 0.9.25'
  gem 'rake',		'~> 0.8.7'
  gem 'jeweler',	'~> 1.4.0', :git => 'git://github.com/technicalpickles/jeweler.git'
end

group :doc do
  case RUBY_PLATFORM
  when 'java'
    gem 'maruku',	'~> 0.6.0'
  else
    gem 'rdiscount',	'~> 1.6.3'
  end

  gem 'yard',			'~> 0.5.3'
end

gem 'rspec',	'~> 1.3.0', :group => [:development, :test]
