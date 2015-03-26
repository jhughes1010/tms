class TmsController < ApplicationController
  def viewAll
    @tasks = Task.all
  end
end
