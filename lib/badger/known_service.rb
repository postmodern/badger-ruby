require 'badger/service'

module Badger
  class KnownService < Service

    def inspect
      "#<#{self.class}: #{@client.uri}>"
    end

  end
end
