class TmsController < ApplicationController
  def viewAll
    @tasks = Task.recent(60)
  end
end
