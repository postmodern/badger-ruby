require 'badger/known_service'

module Badger
  module Services
    class Sys < KnownService

      def time
        Time.at(call(:time))
      end

      def chdir(path)
        call(:chdir,path)
      end

      def get_hostname
        call(:gethostname)
      end

      def get_domainname
        call(:getdomainname)
      end

      def get_cwd
        call(:getcwd)
      end

      def get_pid
        call(:getpid)
      end

      def get_uid
        call(:getuid)
      end

      def get_euid
        call(:geteuid)
      end

      def get_gid
        call(:getgid)
      end

      def get_egid
        call(:getegid)
      end

      def popen(command,&block)
        call(:popen,command.to_s,&block)
      end

    end
  end
end
