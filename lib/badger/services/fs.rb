require 'badger/known_service'
require 'badger/remote_file'

module Badger
  module Services
    class FS < KnownService

      def open(path)
        RemoteFile.new(self,call(:open,path))
      end

    end
  end
end
