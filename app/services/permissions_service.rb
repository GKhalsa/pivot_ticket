class PermissionsService

  def initialize(user, controller, action)
    @_user = user || User.new
    @_controller = controller
    @_action = action
  end

  def allow?
    case
    when user.business_admin? then business_admin_permissions
    else
    true
    end
  end

  private

    def business_admin_permissions
      true
    end

    def user
      @_user
    end

    def controller
      @_controller
    end

    def action
      @_action
    end

end
