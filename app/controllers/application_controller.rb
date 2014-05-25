class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :nav_pages
  helper_method :administrator?

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  after_filter :verify_policy_scoped, only: :index

  private

  def nav_pages
    Page.all.where(published: true)
  end

  def administrator?
    if current_user
      return true if current_user.administrator?
    end
    false
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
end
