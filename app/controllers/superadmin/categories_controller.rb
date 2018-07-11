class Superadmin::CategoriesController < Superadmin::ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]
  def index
    @categories = Category.all
  end
  def new
    @category = Category.new
  end
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Categoría creada con éxito."
      redirect_to superadmin_categories_path
    else
      flash.now[:alert] = "Hubo un problema. Categoría no creada."
      render 'new'
    end
  end
  def edit

  end
  def update
    if @category.update(category_params)
      flash[:notice] = "Categoría editada con éxito."
      redirect_to superadmin_categories_path
    else
      flash.now[:alert] = "Hubo un problema. No se pudo actualizar la categoría."
      render 'edit'
    end
  end
  def destroy
    @category.destroy
    flash[:alert] = "Se ha borrado la categoría"
    redirect_to superadmin_categories_path
  end

  private
  def category_params
    params.require(:category).permit(:name, :summary)
  end

  def set_category
    @category = Category.friendly.find(params[:id])
  end
end
