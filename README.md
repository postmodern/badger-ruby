# Badger-Ruby

* [github.com/postmodern/badger-ruby](http://github.com/postmodern/badger-ruby/)
* [github.com/postmodern/badger-ruby/issues](http://github.com/postmodern/badger-ruby/issues)
* Postmodern (postmodern.mod3 at gmail.com)

## Description

badger-ruby is a Ruby client for communicating with Badger servers.

## Features

* Provides a Client which can connect to or listen for connections
  from servers.
* Supports the following Services:
  * sys ({Badger::Services::Sys})
  * fs ({Badger::Services::FS})
  * ffi ({Badger::Services::FFI})
* Provides Ruby convenience classes which provide transparent access to
  remote resources:
  * {Badger::RemoteFile}
  * {Badger::RemoteLibrary}
  * {Badger::RemoteFunction}

## Requirements

* [ffi-msgpack](http://github.com/postmodern/ffi-msgpack) ~> 0.1.2
* [ffi-rzmq](http://github.com/chuckremes/ffi-rzmq.git) ~> 0.4.1

## Install

    $ sudo gem install badger-ruby

## License

See {file:LICENSE.txt} for license information.

