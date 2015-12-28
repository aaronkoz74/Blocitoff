class SessionsController < Devise::SessionsController

  def create
    super
    if create_session?
      user.save!
      redirect_to root_path
    end
  end

  def destroy
    super
    redirect_to root_path
  end
end
