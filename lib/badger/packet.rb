require 'badger/exceptions/corrupted_packet'

require 'ffi/msgpack'

module Badger
  module Packet
    # The length of the packet header
    HEADER_SIZE = (1 + 4)

    # The minimum total size of a packet
    MIN_SIZE = (HEADER_SIZE + 7)

    # The Badger Protocol version
    PROTOCOL_VERSION = 0x01

    def Packet.validate(packet)
      if packet.length < MIN_SIZE
        raise(CorruptedPacket,"the received badger packet was below the minimum required size",caller)
      end

      version = packet.unpack('C').first

      unless version == PROTOCOL_VERSION
        raise(CorruptedPacket,"the received badger packet had an incorrect protocol version",caller)
      end

      claimed_checksum = packet[1...5].unpack('N').first
      packed_payload = packet[5..-1]

      unless claimed_checksum == Packet.crc32(packed_payload)
        raise(CorruptedPacket,"the received badger packet had an invalid checksum",caller)
      end

      return true
    end

    def Packet.pack(payload)
      packed_payload = FFI::MsgPack.pack(payload)
      checksum = Packet.crc32(packed_payload)

      packet = ''

      packet << PROTOCOL_VERSION.chr
      packet << [checksum].pack('N')
      packet << packed_payload

      return packet
    end

    def Packet.unpack(packet)
      Packet.validate(packet)

      payload = FFI::MsgPack.unpack(packet[5..-1])

      unless payload.kind_of?(Array)
        raise(CorruptedPacket,"the received badger packet did not contain a MsgPack Array",caller)
      end

      if payload.length < 2
        raise(CorruptedPacket,"the received badger packet had less then 2 fields",caller)
      end

      return payload
    end

    protected

    #
    # Calculates the CRC32 checksum of the packed payload.
    #
    # @param [String] packed_payload
    #   The packed payload.
    #
    # @return [Integer]
    #   The CRC32 checksum.
    #
    def Packet.crc32(packed_payload)
      r = 0xffffffff

      packed_payload.each_byte do |b|
        r ^= b
        8.times { r = ((r >> 1) ^ (0xEDB88320 * (r & 1))) }
      end

      return r ^ 0xffffffff
    end
  end
end
