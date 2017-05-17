class RngController < ApplicationController
  
  skip_filter :authorize

  require 'socket'
  require 'timeout'

  def index
    @IPHash = {"10.95.111.200" => "Pass","10.95.111.201" => "Pass", "10.164.21.241" => "Pass", "10.164.21.242" => "Pass", "10.95.111.41" => "Pass" } 
    @IPHash.each {|k,v|
      s = UDPSocket.new
      s.connect(k, 10001)
      s.send("rng", 0)
      @passFlag="Pass"
      response='0,unassigned' 
      begin
        status = Timeout::timeout(3) {response, remote = s.recvfrom(100)}
      rescue 
        @passFlag = "Fail - No Response - timeout failure"
      end
      if @passFlag == "Pass"
	      parts = response.split(",")
        if parts[0] == '1'
          puts parts[1]
          @passFlag = "Pass"
        else
          puts "Error generating random number"
          @passFlag = "Fail - RNG error code, no valid number. Please restart Pi and server."
        end
      end
      s.close
      @IPHash[k] = @passFlag
    }
  end
end
