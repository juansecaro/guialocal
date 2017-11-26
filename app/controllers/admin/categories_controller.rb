class Admin::CategoriesController < Admin::ApplicationController
  def index

  end
  def new
    @category = Category.new
  end
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Categoría creada con éxito."
      redirect_to admin_categories_path
    else
      flash.now[:alert] = "Hubo un problema. Categoría no creada."
      render 'new'
    end
  end
  def edit

  end
  def update

  end
  def destroy

  end

  private
  def category_params
    params.require(:category).permit(:name, :summary)
  end

end
