module Badger
  class Service

    # Name of the service
    attr_reader :name

    def initialize(client,name)
      @client = client
      @name = name.to_s
    end

    def call(name,*args)
      client.call(@name,name,*args)
    end

    protected

    def method_missing(name,*args)
      call(name,*args)
    end

  end
end
