class SampleFrontController < ApplicationController
  def index
    @manids = Manid.all
    @samples = Sample.all
  end

end
