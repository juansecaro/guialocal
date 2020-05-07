class Superadmin::ProspectsController < Superadmin::ApplicationController
  before_action :set_prospect, only: [:edit, :update, :show]

  def index
    @prospects = Prospect.where.not(status: 'created')
  end

  def edit
    # code
  end

  def update
    if change?
      if @prospect.update(prospect_params)
        redirect_to superadmin_prospects_path, notice: 'Prospect editado.'
      else
        render :edit
        flash.now[:alert] = 'Prospect no actualizado'
      end
    elsif generate?
      @prospect.update(prospect_params)
      generate_user_and_empresa_from_prospect(@prospect)
      redirect_to superadmin_users_path, notice: 'Usuario y empresa creados. Prospect archivado.'
    end
  end

  def set_prospect
    @prospect = Prospect.find(params[:id])
  end

  private
  def prospect_params
    params.require(:prospect).
      permit(:user_first_name, :user_last_name, :user_email, :dni, :plan, :empresa_name, :empresa_email,
         :empresa_phone, :empresa_address, :empresa_web, :empresa_category, :empresa_summary, :user_birthday,
       :user_phone, :user_address, :sex, :iban_code, :status, :conditions_accepted, :prospect_id, :original_plan,
       :date_of_acceptance, :ip_address)
  end

  def change?
    params[:commit] == "Guardar"
  end

  def generate?
    params[:commit] == "Generar"
  end

  #It creates user and empresa from prospect
  def generate_user_and_empresa_from_prospect(prospect)

    user = User.create!(
      email: prospect.user_email,
      first_name: prospect.user_first_name,
      last_name: prospect.user_last_name,
      birthdate:prospect.user_birthday,
      dni: prospect.dni,
      phone: prospect.user_phone,
      address: prospect. user_address,
      password: prospect.dni,
      password_confirmation: prospect.dni,
      conditions_accepted: prospect.conditions_accepted,
      date_of_acceptance: prospect.date_of_acceptance,
      ip_address: prospect.ip_address,
    )

    empresa = user.empresas.create(
      name: prospect.empresa_name,
      category_id: prospect.empresa_category,
      plan: prospect.plan,
      address: prospect.empresa_address,
      excerpt: prospect.empresa_summary,
      web: prospect.empresa_web,
      email: prospect.empresa_email,
      tel: prospect.empresa_phone,
    )
    user.current_empresa = empresa.id
    user.save
    prospect.status = 'archived'
    prospect.save

  end

end
