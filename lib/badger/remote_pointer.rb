require 'enumerator'

module Badger
  class RemotePointer

    attr_reader :address

    def initialize(ffi,address)
      @ffi = ffi
      @address = address
    end

    def get_array_of_char(offset,length)
      @ffi.call(:read,@address,:int,offset,length)
    end

    def get_array_of_short(offset,length)
      @ffi.call(:read,@address,:short,offset,length)
    end

    def get_array_of_int(offset,length)
      @ffi.call(:read,@address,:int,offset,length)
    end

    def get_array_of_long(offset,length)
      @ffi.call(:read,@address,:long,offset,length)
    end

    def get_array_of_int8(offset,length)
      @ffi.call(:read,@address,:int8,offset,length)
    end

    def get_array_of_int16(offset,length)
      @ffi.call(:read,@address,:int16,offset,length)
    end

    def get_array_of_int32(offset,length)
      @ffi.call(:read,@address,:int32,offset,length)
    end

    def get_array_of_int64(offset,length)
      @ffi.call(:read,@address,:int64,offset,length)
    end

    def get_array_of_uchar(offset,length)
      @ffi.call(:read,@address,:uchar,offset,length)
    end

    def get_array_of_ushort(offset,length)
      @ffi.call(:read,@address,:ushort,offset,length)
    end

    def get_array_of_uint(offset,length)
      @ffi.call(:read,@address,:uint,offset,length)
    end

    def get_array_of_ulong(offset,length)
      @ffi.call(:read,@address,:ulong,offset,length)
    end

    def get_array_of_uint8(offset,length)
      @ffi.call(:read,@address,:uint8,offset,length)
    end

    def get_array_of_uint16(offset,length)
      @ffi.call(:read,@address,:uint16,offset,length)
    end

    def get_array_of_uint32(offset,length)
      @ffi.call(:read,@address,:uint32,offset,length)
    end

    def get_array_of_uint64(offset,length)
      @ffi.call(:read,@address,:uint64,offset,length)
    end

    def get_array_of_float(offset,length)
      @ffi.call(:read,@address,:float,offset,length)
    end

    def get_array_of_double(offset,length)
      @ffi.call(:read,@address,:double,offset,length)
    end

    def get_array_of_pointer(offset,length)
      ptrs = @ffi.call(:read,@address,:pointer,offset,length)
      ptrs.map! { |ptr| self.class.new(ptr) }

      return ptrs
    end

    def get_char(offset=0)
      get_array_of_char(offset,1).first
    end

    def get_short(offset=0)
      get_array_of_short(offset,1).first
    end

    def get_int(offset=0)
      get_array_of_int(offset,1).first
    end

    def get_long(offset=0)
      get_array_of_long(offset,1).first
    end

    def get_int8(offset=0)
      get_array_of_int8(offset,1).first
    end

    def get_int16(offset=0)
      get_array_of_int16(offset,1).first
    end

    def get_int32(offset=0)
      get_array_of_int32(offset,1).first
    end

    def get_int64(offset=0)
      get_array_of_int64(offset,1).first
    end

    def get_uchar(offset=0)
      get_array_of_uchar(offset,1).first
    end

    def get_ushort(offset=0)
      get_array_of_ushort(offset,1).first
    end

    def get_uint(offset=0)
      get_array_of_uint(offset,1).first
    end

    def get_ulong(offset=0)
      get_array_of_ulong(offset,1).first
    end

    def get_uint8(offset=0)
      get_array_of_uint8(offset,1).first
    end

    def get_uint16(offset=0)
      get_array_of_uint16(offset,1).first
    end

    def get_uint32(offset=0)
      get_array_of_uint32(offset,1).first
    end

    def get_uint64(offset=0)
      get_array_of_uint64(offset,1).first
    end

    def get_float(offset=0)
      get_array_of_float(offset,1).first
    end

    def get_double(offset=0)
      get_array_of_double(offset,1).first
    end

    def get_pointer(offset=0)
      get_array_of_pointer(offset,1).first
    end

    alias get_bytes get_array_of_uchar
    alias get_byte get_uchar

    def put_array_of_char(offset,data)
      @ffi.call(:write,@address,:int,offset,data)
    end

    def put_array_of_short(offset,data)
      @ffi.call(:write,@address,:short,offset,data)
    end

    def put_array_of_int(offset,data)
      @ffi.call(:write,@address,:int,offset,data)
    end

    def put_array_of_long(offset,data)
      @ffi.call(:write,@address,:long,offset,data)
    end

    def put_array_of_int8(offset,data)
      @ffi.call(:write,@address,:int8,offset,data)
    end

    def put_array_of_int16(offset,data)
      @ffi.call(:write,@address,:int16,offset,data)
    end

    def put_array_of_int32(offset,data)
      @ffi.call(:write,@address,:int32,offset,data)
    end

    def put_array_of_int64(offset,data)
      @ffi.call(:write,@address,:int64,offset,data)
    end

    def put_array_of_uchar(offset,data)
      @ffi.call(:write,@address,:uchar,offset,data)
    end

    def put_array_of_ushort(offset,data)
      @ffi.call(:write,@address,:ushort,offset,data)
    end

    def put_array_of_uint(offset,data)
      @ffi.call(:write,@address,:uint,offset,data)
    end

    def put_array_of_ulong(offset,data)
      @ffi.call(:write,@address,:ulong,offset,data)
    end

    def put_array_of_uint8(offset,data)
      @ffi.call(:write,@address,:uint8,offset,data)
    end

    def put_array_of_uint16(offset,data)
      @ffi.call(:write,@address,:uint16,offset,data)
    end

    def put_array_of_uint32(offset,data)
      @ffi.call(:write,@address,:uint32,offset,data)
    end

    def put_array_of_uint64(offset,data)
      @ffi.call(:write,@address,:uint64,offset,data)
    end

    def put_array_of_float(offset,data)
      @ffi.call(:write,@address,:float,offset,data)
    end

    def put_array_of_double(offset,data)
      @ffi.call(:write,@address,:double,offset,data)
    end

    def put_array_of_pointer(offset,data)
      @ffi.call(:write,@address,:pointer,offset,data)
    end

    def put_char(offset=0)
      put_array_of_char(offset,1)
    end

    def put_short(offset=0)
      put_array_of_short(offset,1)
    end

    def put_int(offset=0)
      put_array_of_int(offset,1)
    end

    def put_long(offset=0)
      put_array_of_long(offset,1)
    end

    def put_int8(offset=0)
      put_array_of_int8(offset,1)
    end

    def put_int16(offset=0)
      put_array_of_int16(offset,1)
    end

    def put_int32(offset=0)
      put_array_of_int32(offset,1)
    end

    def put_int64(offset=0)
      put_array_of_int64(offset,1)
    end

    def put_uchar(offset=0)
      put_array_of_uchar(offset,1)
    end

    def put_ushort(offset=0)
      put_array_of_ushort(offset,1)
    end

    def put_uint(offset=0)
      put_array_of_uint(offset,1)
    end

    def put_ulong(offset=0)
      put_array_of_ulong(offset,1)
    end

    def put_uint8(offset=0)
      put_array_of_uint8(offset,1)
    end

    def put_uint16(offset=0)
      put_array_of_uint16(offset,1)
    end

    def put_uint32(offset=0)
      put_array_of_uint32(offset,1)
    end

    def put_uint64(offset=0)
      put_array_of_uint64(offset,1)
    end

    def put_float(offset=0)
      put_array_of_float(offset,1)
    end

    def put_double(offset=0)
      put_array_of_double(offset,1)
    end

    def put_pointer(offset=0)
      put_array_of_pointer(offset,1)
    end

    alias put_bytes put_array_of_uchar
    alias put_byte put_uchar

    def free
      @ffi.free(@address)
    end

    def to_i
      @address.to_i
    end

    def inspect
      "#<#{self.class}: #{@ffi.client.uri} #{"0x%x" % @address}>"
    end

  end
end
