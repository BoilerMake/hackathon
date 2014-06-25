class ExecsController < ApplicationController
  def applied
    @count = Application.all.count
  end
end
