class Admin::CategoriesController < Admin::BaseController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to new_admin_event_path(current_user.venue.slug)
    else
      flash[:notice] = @category.errors.full_messages.join(", ")
      redirect_to new_admin_category_path
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
