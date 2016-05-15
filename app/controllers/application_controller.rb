class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :set_cart
  before_action :set_cart, :authorize!

  add_flash_types :success, :info, :warning, :danger

  def set_cart
    @cart ||= Cart.new(session[:cart])
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def platform_admin?
    current_user.platform_admin?
  end

  def require_login
    redirect_to login_path unless current_user
  end

  def not_found
    raise ActionController::RoutingError.new("Not Found")
  end

  def current_permission
    @current_permission || PermissionsService.new(current_user, params[:controller], params[:action])
  end

  def authorize!
    unless current_permission.allow?
      # binding.pry
      render file: 'public/404'
    end
  end
end
