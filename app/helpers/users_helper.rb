module UsersHelper
  # if there is none assigned while existing, it will assign the first to exist
  def set_current_empresa(user, identificator = nil)
    if (!user.current_empresa)
      if (identificator.nil?)
        user.current_empresa = user.try(:empresas).try(:first).try(:id)
      else
        user.current_empresa = identificator
      end
      user.save
    end
  end

  def several_empresas
    return true if current_user.empresas.count > 1
  end

end
