module EmpresasHelper
  def change_empresa
    authenticate_user!

    if current_user.empresas.count > 1

      i = 0
      enc = false

      ids = current_user.empresas.map{|empresa| empresa.id }

      while !enc
        if current_user.current_empresa == ids[i]
          if ids[i+1].nil?
            current_user.current_empresa = ids[0]
          else
            current_user.current_empresa = ids[i+1]
          end
          enc = true
          current_user.save
        end
        i = i + 1
      end

    end
  end

end
