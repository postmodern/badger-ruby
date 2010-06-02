module Badger
  class RemoteFile < IO

    SEEK_NAMES = {
      SEEK_SET => :set,
      SEEK_CUR => :current,
      SEEK_END => :end
    }

    def initialize(fs,fd)
      @fs = fs
      @fd = fd
    end

    def sysseek(offset,whence=SEEK_SET)
      @fs.call(:seek,@fd,offset,SEEK_NAMES[whence])
    end

    def sysread(length)
      @fs.call(:read,@fd,length)
    end

    def syswrite(data)
      @fs.call(:write,@fd,data)
    end

    def inspect
      "#<#{self.class}: #{@fs.client.uri}: @fd=#{@fd}>"
    end

  end
end
