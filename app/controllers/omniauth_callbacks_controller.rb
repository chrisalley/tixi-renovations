class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      #redirect_to root_url, notice: "Successfully logged in through Twitter."
      notice = "Successfully logged in through Twitter."
      sign_in_and_redirect user
    else
      redirect_to root_url, notice: "Account could not be authenticated."
    end
  end
end
