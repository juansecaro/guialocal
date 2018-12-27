class SuscriptorsController < ApplicationController
  def new
    @suscriptor = Suscriptor.new
  end

  def create
    @suscriptor = Suscriptor.new(suscriptor_params)

    @suscriptor = Suscriptor.find_or_create_by(email: @suscriptor.email) 
    if @suscriptor.persisted?
      if (@suscriptor.email_confirmation == true)
        flash[:notice] = "Ya estás registrado/a"
        redirect_to root_path
      else
        SuscriptorMailer.registration_confirmation(@suscriptor).deliver
      end
    else
      flash[:error] = "Ha ocurrido un error. Contáctanos desde la sección contacto y explícanos"
      render 'new'
    end
  end

  def confirm_email
    @suscriptor = Suscriptor.find_by_token_confirmation(params[:id])
    if !@suscriptor.blank?
        @suscriptor.email_confirmation = true
        @suscriptor.token_confirmation = nil
        @suscriptor.save!(:validate => false)
    else
      flash[:error] = "Ha ocurrido un error. Contactanos sobre esto"
      redirect_to root_path
    end
  end
  #Not finished
  def unsuscribe
    @suscriptor = Suscriptor.find_by_email(params[:email])

    if !@suscriptor.blank?
      @suscriptor.email_confirmation = false
      @suscriptor.save!(:validate => false)
    else
      flash[:error] = "Ha ocurrido un error. Contactanos sobre esto"
      redirect_to root_path
    end
  end

  private
  def suscriptor_params
    params.require(:suscriptor).permit(:email, :email_confirmation, :token_confirmation)
  end


end
