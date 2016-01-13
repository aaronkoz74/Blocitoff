class User < ActiveRecord::Base
  has_many :items
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates_presence_of :username
  validates_uniqueness_of :username, :email

  def confirm!
    super
    welcome_message
  end

  def email_required?
    false
  end


  private

  def welcome_message
    UserMailer.welcome_message(self).deliver
  end
end
