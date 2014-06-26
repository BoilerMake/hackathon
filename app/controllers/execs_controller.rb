class ExecsController < ApplicationController
  def applied
    @count = Hacker.all.count
  end
end
