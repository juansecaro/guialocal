class SuscriptorsController < ApplicationController
  invisible_captcha only: :create, honeypot: :subtitle, on_spam: :spam_received
  def new
    @suscriptor = Suscriptor.new
  end

  def create
    @suscriptor = Suscriptor.new(suscriptor_params)

    if !@suscriptor.valid?
      flash[:error] = "El email debe ser válido"
      render 'new'
    else
      @suscriptor = Suscriptor.find_or_create_by(email: @suscriptor.email) do |suscriptor|
        empresa_id = suscriptor_params[:empresa_id].to_i
        if (empresa_id == 0)
          suscriptor.empresa_id = nil
        else
          suscriptor.empresa_id = empresa_id
        end
      end
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
      flash[:notice] = "Suscripción al mercadillo digital anulada. No volverás a recibir correos."
      redirect_to root_path

    else
      flash[:error] = "Ha ocurrido un error. Contactanos sobre esto"
      redirect_to root_path
    end
  end

  private
  def suscriptor_params
    params.require(:suscriptor).permit(:email, :email_confirmation, :token_confirmation, :subtitle, :empresa_id)
  end

  def spam_received
    redirect_to root_path
  end

end
