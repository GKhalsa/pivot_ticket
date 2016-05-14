class UsersController < ApplicationController
  before_action :require_login, only: [:show, :dashboard]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Account successfully created"
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash[:notice] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  def dashboard
    @user = current_user
    render :dashboard
  end

  def show
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :name,
    )
  end

  def require_login
    redirect_to login_path unless current_user
  end
end
