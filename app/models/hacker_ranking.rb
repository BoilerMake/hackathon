class HackerRanking < ActiveRecord::Base
  belongs_to :hacker
  belongs_to :exec
end
