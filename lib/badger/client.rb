require 'badger/packet'
require 'badger/request'
require 'badger/response'
require 'badger/service'
require 'badger/services'

require 'ffi-rzmq'

module Badger
  class Client

    KNOWN_SERVICES = {
      :sys => Services::Sys
    }

    attr_reader :uri

    def initialize
      @uri = nil
      @request_id = Request::ID_MIN
      @services = {}

      @decoder = nil
      @encoder = nil

      @context = nil
      @socket = nil
    end

    def connect(uri)
      @uri = uri
      @context = ZMQ::Context.new(1, 1, 0)
      @socket = @context.socket(ZMQ::PAIR)

      @socket.connect(@uri)
      return true
    end

    def listen(uri)
      @uri = uri
      @context = ZMQ::Context.new(1, 1, 0)
      @socket = @context.socket(ZMQ::PAIR)

      @socket.bind(@uri)
      return true
    end

    def ping
      push [@request_id, Request::PING]
      t1 = Time.now

      payload = pull
      t2 = Time.now

      return (t2 - t1)
    end

    def load_services
      push [@request_id, Request::SERVICES]

      payload = pull

      unless payload[2].kind_of?(Array)
        raise(CorruptedPacket,"the received badger packet did not contain an Array of Service names",caller)
      end

      @services = {}

      payload[2].each do |name|
        name = name.to_sym
        service_class = (KNOWN_SERVICES[name] || Service)

        @services[name] = service_class.new(self,name)
      end

      return @services
    end

    def services
      if @services.empty?
        load_services
      else
        @services
      end
    end

    def functions(service)
      push [@request_id, Request::FUNCTIONS, service]

      payload = pull

      unless payload[2].kind_of?(Array)
        raise(CorruptedPacket,"the received badger packet did not contain an Array of Function names",caller)
      end

      return payload[2]
    end

    def prototype(service,name)
      push [@request_id, Request::PROTOTYPE, service, name]

      payload = pull
      ret_type = payload[2]
      arg_types = payload[3]

      unless ret_type
        raise(CorruptedPacket,"the received badger packet did not contain a return type",caller)
      end

      ret_type = ret_type.to_sym

      if arg_types.kind_of?(Array)
        arg_types.map! { |arg_type| arg_type.to_sym }
      elsif arg_types
        raise(CorruptedPacket,"the received badger packet did not contain a nil or an Array of argument types",caller)
      end

      return [ret_type, arg_types]
    end

    def call(service,name,*args)
      push [@request_id, Request::CALL, service, name, args]

      loop do
        payload = pull

        case payload[1]
        when Response::YIELD
          yield(*payload[2]) if block_given?
        when Response::RETURN
          return payload[2]
        when Response::ERROR
          raise(RuntimeError,payload[2],caller)
        end
      end
    end

    def close
      @context.terminate

      @socket = nil
      @context = nil
      return true
    end

    def to_s
      @uri
    end

    protected

    def push(payload)
      packet = Packet.pack(payload)

      if @encoder
        packet = @encoder.call(packet)
      end

      @socket.send_string(packet,0)

      @request_id += 1

      if @request_id > Request::ID_MAX
        @request_id = Request::ID_MIN
      end
    end

    def pull
      packet = @socket.recv_string(0)

      if packet.length < Packet::MIN_SIZE
        raise(CorruptedPacket,"the received badger packet was below the minimum required size",caller)
      end

      if @decoder
        packet = @decoder.call(packet)
      end

      return Packet.unpack(packet)
    end

    def method_missing(name,*args,&block)
      if (args.empty? && block.nil?)
        return services[name] if services.has_key?(name)
      end

      super(name,*args)
    end

  end
end
