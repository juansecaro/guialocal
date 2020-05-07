class ProspectsController < ApplicationController
  include Wicked::Wizard

  steps :sign_up, :business_details, :user_details

  def show
    create if params[:prospect_id].nil?
    @prospect = Prospect.find(params[:prospect_id])

    case step
    when :sign_up

    when :business_details
      #Rails.logger.info(session[:plan])
    when :user_details
    end
    render_wizard
  end

  def update
    @prospect = Prospect.find(params[:prospect_id])
    params[:prospect][:status] = step.to_s
    if step == steps.last
      params[:prospect][:status] = 'completed'
      params[:prospect][:original_plan] = @prospect.plan
      params[:prospect][:date_of_acceptance] = Time.now
      params[:prospect][:ip_address] = request.remote_ip
      ProspectMailer.new_prospect_notification(@prospect).deliver
      ProspectMailer.prospect_confirmation(@prospect).deliver
      flash[:notice] = "Gracias por tu solicitud. Nos pondremos en contacto contigo."
    end
    @prospect.update_attributes(prospect_params)
    if @prospect.errors.any?
      flash[:error] = @prospect.errors.full_messages
    end
    render_wizard @prospect
  end

  def create
    @prospect = Prospect.create
    redirect_to wizard_path(steps.first, prospect_id: @prospect.id)
  end

  def info
    session[:plan] = params[:plan]
  end

  def prospect_params
    params.require(:prospect).
      permit(:user_first_name, :user_last_name, :user_email, :dni, :plan, :original_plan, :empresa_name, :empresa_email,
         :empresa_phone, :date_of_acceptance, :ip_address, :empresa_address, :empresa_email, :empresa_web, :empresa_category, :empresa_summary, :user_birthday,
       :user_phone, :user_address, :sex, :iban_code, :status, :conditions_accepted, :prospect_id)
  end
end
