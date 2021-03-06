class PermissionsService
  extend Forwardable

  def_delegators :user,
                 :platform_admin?,
                 :venue_admin?,
                 :registered_user?,
                 :business_admin?

  def initialize(user, controller, action)
    @_user = user || User.new
    @_controller = controller
    @_action = action
  end

  def allow?
    case
    when platform_admin? && platform_admin_permissions then true
    when business_admin? && business_admin_permissions then true
    when registered_user? && registered_user_permissions then true
    else
      guest_user_permissions
    end
  end

  private

    def platform_admin_permissions
      return true if controller == "events"
      return true if controller == "admin/orders"
      return true if controller == "admin/dashboard" && action.in?(%w(show))
      return true if controller == "admin/venues"
      return true if controller == "admin/categories" && action.in?(%w(new create))
      return true if controller == "admin/tickets"
      return true if controller == "categories"
      business_admin_permissions
    end

    def business_admin_permissions
      return true if controller == "events" && action.in?(%w(index show))
      return true if controller == "admin/venues" && action.in?(%w(index show new edit create update))
      return true if controller == "admin/events" && action.in?(%w(edit destroy new update create))
      return true if controller == "admin/venue_moderators" && action.in?(%w(index new create destroy))
      return true if controller == "venues"
      return true if controller == "orders" && action.in?(%w(index create show))
      return true if controller == "tickets" && action.in?(%w(new create index edit update destroy))
      registered_user_permissions
    end

    def registered_user_permissions
      return true if controller == "orders" && action.in?(%w(index create show))
      return true if controller == "tickets" && action.in?(%w(activate de_activate index new create edit update destroy))
      return true if controller == "tickets" && action.in?(%w(index new create edit update destroy))
      return true if controller == "users" && action.in?(%w(edit update))
      return true if controller == "admin/venues" && action.in?(%w(new create index show))
      guest_user_permissions
    end

    def guest_user_permissions
      return true if controller == "categories" && action.in?(%w(show))
      return true if controller == "events" && action.in?(%w(index show))
      return true if controller == "orders" && action.in?(%w(create))
      return true if controller == "carts"
      return true if controller == "venues" && action.in?(%w(show))
      return true if controller == "sessions"
      return true if controller == "users" && action.in?(%w(new create dashboard))
      return true if controller == "tickets" && action.in?(%w(index new qr))
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
