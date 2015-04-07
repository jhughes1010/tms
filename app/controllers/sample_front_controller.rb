class SampleFrontController < ApplicationController
  skip_filter :authorize
  
  def index
    @manids = Manid.all
    @samples = Sample.all
  end

end
