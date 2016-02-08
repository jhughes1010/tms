class RngController < ApplicationController

  require 'socket'
  require 'timeout'

  def index



    @IPHash = {"10.95.111.200" => "Pass","10.95.111.201" => "Pass", "10.95.111.202" => "Pass", "10.95.111.203" => "Pass", "10.95.111.41" => "Pass" } 
    @IPHash.each {|k,v|
    s = UDPSocket.new
    s.connect(k, 10001)

    s.send("rng", 0)
      
    (Timeout.timeout(1) {response, remote = s.recvfrom(100)}) rescue @passFlag = "Fail"
    unless @passFlag == "Fail"
      parts = response.split(",")

      if parts[0] == '1'
        puts parts[1]
      @passFlag = "Pass"
      else
        puts "Error generating random number"
        @passFlag = "Fail"
      end
    else
      @passFlag = "Fail"
    end

    s.close
    @IPHash[k] = @passFlag
  }
end

end