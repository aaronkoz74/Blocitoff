class Item < ActiveRecord::Base
  belongs_to :user

  attr_accessor :task, :time_remaining

  def time_remaining(entry)
    limit = 7.days
    span = distance_of_time_in_words(entry.created_at, Time.now)

    if span <= limit
      limit - span
    else
      "Overdue!"
    end
  end


end
