require 'badger/known_service'
require 'badger/remote_library'

module Badger
  module Services
    class FFI < KnownService

      def initialize(client,name)
        super(client,name)

        @libraries = {}
      end

      def open(path)
        if call(:open,path)
          @libraries[path] ||= RemoteLibrary.new(self,path)
        end
      end

      def libraries
        call(:libraries)
      end

      def close(path)
        if call(:close,path)
          @libraries.delete(path)
          return true
        end
      end

      def [](path)
        @libraries[path]
      end

    end
  end
end
