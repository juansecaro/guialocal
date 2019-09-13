class Superadmin::AmbassadorsController < Superadmin::ApplicationController
  before_action :set_ambassador, only: [:edit, :update, :destroy]

  def index
    @ambassadors = Ambassador.all
  end

  def new
    @ambassador = Ambassador.new
  end

  def create
    @ambassador = Ambassador.new(ambassador_params)

    respond_to do |format|
      if @ambassador.save!
        format.html { redirect_to @ambassador, notice: 'El embajador se ha creado con éxito' }
        format.json { render :show, status: :created, location: @ambassador }
      else
        format.html { render :new }
        format.json { render json: @ambassador.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      if @ambassador.update(ambassador_params)
        format.html { redirect_to superadmin_ambassadors_path, notice: 'El embajador se ha actualizado con éxito' }
        format.json { render :show, status: :ok, location: @ambassador }
      else
        format.html { render :edit }
        format.json { render json: @ambassador.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ambassador.destroy
    respond_to do |format|
      format.html { redirect_to superadmin_ambassadors_path, notice: 'Embajador eliminado.' }
      format.json { head :no_content }
    end
  end
  private

  def set_ambassador
    @ambassador = Ambassador.friendly.find(params[:id])
  end

  def ambassador_params
    params.require(:ambassador).permit(:name, :picture, :country, :language, :gender, :bio_original, :bio_english, :bio_native,
       :review_original, :review_english, :review_native, :partner_name, :partner_profile, :video_interview, :video_testimonial,{gallery:[]})
  end
end
