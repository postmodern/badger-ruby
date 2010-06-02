module Badger
  class RemoteFunction

    def initialize(lib,name,arg_types,ret_type)
      @lib = lib
      @name = name
      @arg_types = arg_types
      @ret_type = ret_type
    end

    def call(*args)
      @lib.invoke(@name,*args)
    end

    def inspect
      "#<#{self.class}: #{@ret_type} #{@name}(#{@arg_types.join(', ')})>"
    end

  end
end
