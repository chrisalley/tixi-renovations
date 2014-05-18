class SessionsController < Devise::SessionsController
  def create
    redirect_to user_omniauth_authorize_path(:twitter)
  end
end
