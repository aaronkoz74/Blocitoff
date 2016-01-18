class Item < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  belongs_to :user

  def time_remaining
    ((self.created_at - (7.days.ago.middle_of_day))/86400).to_i
  end
end
