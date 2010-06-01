require 'badger/known_service'

require 'set'

module Badger
  module Services
    class FFI < KnownService

      def initialize(client,name)
        super(client,name)

        @libraries = Set[]
      end

      def open(name)
        if call(:open,name)
          @libraries << name
          return true
        end
      end

      def libraries
        call(:libraries)
      end

      def exposed_functions(name)
        names = call(:exposed_functions,name)
        names.map! { |name| name.to_sym }

        return names
      end

      def exposed_function(lib,name)
        args, ret = call(:exposed_function,lib,name)
        args.map! { |name| name.to_sym }

        return [args, ret.to_sym]
      end

      def invoke(lib,name,*args)
        call(:invoke,lib,name,args)
      end

      def close(name)
        if call(:close,name)
          @libraries.delete(name)
          return true
        end
      end

    end
  end
end
