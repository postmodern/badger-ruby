require 'badger/remote_function'

require 'set'

module Badger
  class RemoteLibrary

    attr_reader :path

    def initialize(ffi,path)
      @ffi = ffi
      @path = path

      @exposed_functions = Set[]
    end

    def attach_function(name,arg_types,ret_type)
      if @ffi.call(:attach_function,@path,name,arg_types,ret_type)
        @exposed_functions << name.to_sym
      end
    end

    def exposed_functions
      functions = @ffi.call(:exposed_functions,@path)
      functions.map! { |name| name.to_sym }

      @exposed_functions += functions
      return @exposed_functions
    end

    def exposed_function(name)
      name = name.to_sym
      arg_types, ret_type = @ffi.call(:exposed_function,@path,name)

      return RemoteFunction.new(self,name,arg_types,ret_type)
    end

    def invoke(name,*args)
      @ffi.call(:invoke,@path,name,args)
    end

    def close
      @ffi.close(@path)
    end

    def inspect
      "#<#{self.class}: #{@ffi.client.uri} #{@path}>"
    end

    protected

    def method_missing(name,*args,&block)
      if block.nil?
        invoke(name,*args)
      end
    end

  end
end
