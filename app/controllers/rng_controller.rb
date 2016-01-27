class RngController < ApplicationController
  def index

    require 'socket'

    s = UDPSocket.new
    s.connect("10.95.111.200", 10001)
    #loop do
      s.send("rng", 0)
      response, remote = s.recvfrom(100)

      # response is <status,random number> where
      # status is 0 if there was an error generating the random
      # status is 1 if the random was generated
      # random number is 32 byte hex string (64 characters) or 0 if there was an error
      parts = response.split(",")

      if parts[0] == '1'
        puts parts[1]
      @passFlag = "Pass"
    else
        puts "Error generating random number"
        @passFlag = "Fail"
      end

      sleep 0.5
      #end
    
    
    
    
  end

end
