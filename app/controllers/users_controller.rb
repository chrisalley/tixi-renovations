class UsersController < ApplicationController
  before_action :load_user, except: :index
  before_action :set_request_variant

  def index
    @users = policy_scope(User.order(:name).page(params[:page]))
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to users_path, notice: "Successfully updated user."
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "Successfully destroyed user."
  end

  private

  def user_params
    params.require(:user).permit(:administrator)
  end

  def load_user
    @user = User.find params[:id]
    authorize @user
  end

  def set_request_variant
    request.variant = :mobile if browser.mobile?
  end
end
