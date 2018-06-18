class Admin::TagsController < Admin::ApplicationController
  before_action :set_tag, only: [:show, :destroy]
  def show
  end
  def index
    @tags = Tag.all.order(name: :asc)
  end

  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to admin_tags_path, notice: 'Etiqueta destruida.' }
      format.json { head :no_content }
    end
  end

  private
  def set_tag
    @tag = Tag.find(params[:id])

    #Si no lo encuentra
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "La palabra clave que buscas no existe"
    redirect_to (request.referrer || admin_tags_path)
  end
end
