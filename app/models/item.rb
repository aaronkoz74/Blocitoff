class Item < ActiveRecord::Base
  include ActionView::Helpers::DateHelper

  belongs_to :user

  def time_remaining
    ((self.created_at.end_of_day.advance(days: 7)) - Time.zone.now).to_i/86400
  end
end
