class Item < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  belongs_to :user

  def time_remaining
    span = 7 - (distance_of_time_in_words(self.created_at, Time.now)).to_i
  end


end
