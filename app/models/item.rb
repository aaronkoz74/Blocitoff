class Item < ActiveRecord::Base
  belongs_to :user

  attr_accessor :task
end
