require 'badger/exceptions/corrupted_packet'

require 'digest/crc32'
require 'ffi/msgpack'

module Badger
  module Packet
    # The length of the packet header
    HEADER_SIZE = (1 + 4)

    # The minimum total size of a packet
    MIN_SIZE = (HEADER_SIZE + 3)

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

      unless claimed_checksum == Digest::CRC32.checksum(packed_payload)
        raise(CorruptedPacket,"the received badger packet had an invalid checksum",caller)
      end

      return true
    end

    def Packet.pack(payload)
      packed_payload = FFI::MsgPack.pack(payload)
      checksum = Digest::CRC32.checksum(packed_payload)

      packet = ''

      packet << PROTOCOL_VERSION.chr
      packet << [checksum].pack('N')
      packet << packed_payload

      return packet
    end

    def Packet.unpack(packet)
      Packet.validate(packet)

      unpacker = FFI::MsgPack::Unpacker.create(packet.length - HEADER_SIZE)
      unpacker << packet[HEADER_SIZE..-1]

      payload = unpacker.to_a

      if payload.length < 2
        raise(CorruptedPacket,"the received badger packet had less then 2 fields",caller)
      end

      return payload
    end

  end
end
