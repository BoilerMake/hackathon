class ExecsController < ApplicationController
  load_and_authorize_resource
  def applied
    @count = Hacker.all.count
  end
end
