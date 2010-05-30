require 'badger/known_service'

module Badger
  module Services
    class Sys < KnownService

      def time
        Time.at(call(:time))
      end

      def chdir(path)
        call(:chdir,path)
      end

      def getcwd
        call(:getcwd)
      end

    end
  end
end