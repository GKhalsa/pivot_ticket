class PermissionsService
  extend Forwardable

  def_delegators :user,
                 :platform_admin?,
                 :venue_admin?,
                 :registered_user?

  def initialize(user, controller, action)
    @_user = user || User.new
    @_controller = controller
    @_action = action
  end

  def allow?
    case
    when platform_admin? then platform_admin_permissions
    when venue_admin? then venue_admin_permissions
    when registered_user? then registered_user_permissions
    else
      guest_user_permissions
    end
  end

  private

  def platform_admin_permissions
    return true if controller == "sessions"
    return true if controller == "events"
    return true if controller == "admin/dashboard" && action.in?(%w(show))
    return true if controller == "admin/venues" && action.in?(%w(de_activate activate))
  end

  def venue_admin_permissions
    true
  end

  def registered_user_permissions
    true
  end

  def guest_user_permissions
    true
  end

  def controller
    @_controller
  end

  def action
    @_action
  end

  def user
    @_user
  end

end
