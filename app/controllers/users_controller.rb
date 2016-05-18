class UsersController < ApplicationController
  before_action :require_login, only: [:show, :dashboard, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.roles << Role.find_or_create_by(name: "registered_user")
      flash[:notice] = "Account successfully created"
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash[:notice] = @user.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    redirect_to dashboard_path
  end

  def dashboard
    @user = current_user
    render :dashboard
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :name,
      :venue_id)
  end

  def require_login
    redirect_to login_path unless current_user
  end
end
