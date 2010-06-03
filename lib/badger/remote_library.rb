require 'badger/remote_function'

module Badger
  class RemoteLibrary

    attr_reader :path

    attr_reader :exposed_functions

    def initialize(ffi,path)
      @ffi = ffi
      @path = path

      @exposed_functions = {}
    end

    def attach_function(name,arg_types,ret_type)
      name = name.to_sym
      arg_types = arg_types.map { |name| name.to_sym }
      ret_type = ret_type.to_sym

      if @ffi.call(:attach_function,@path,name,arg_types,ret_type)
        @exposed_functions[name] = RemoteFunction.new(self,name,arg_types,ret_type)
      end
    end

    def exposed_function(name)
      name = name.to_sym

      unless @exposed_functions.has_key?(name)
        raise(RuntimeError,"exposed function not found #{name}",caller)
      end

      return @exposed_functions[name]
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
        return invoke(name,*args) if @exposed_functions.has_key?(name)
      end

      return super(name,*args,&block)
    end

  end
end
