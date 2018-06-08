class Superadmin::CreditosController < ApplicationController
  def edit
  end

  def update
    case params[:plan]
    when "basic"
      @empresas = Empresa.where(plan: :basic)
    when "plus"
      @empresas = Empresa.where(plan: :plus)
    when "premium"
      @empresas = Empresa.where(plan: :premium)
    when "todos"
      @empresas = Empresa.where.not(plan: :noplan)
    else
      flash.now[:alert] = "Valor no válido seleccionado."
      render 'edit'
    end

    added_value = number_or_nil(params[:quantity])
    if added_value.nil?
      flash.now[:alert] = "El valor introducido no es válido."
      render 'edit'
    else
      @empresas.each do |empresa|
        empresa.user.creditos += added_value
        if empresa.user.save!
          flash[:notice] = "La operación se ha realizado correctamente"
          redirect_to superadmin_root_path
        else
          flash[:alert] = "El valor introducido no es válido."
          redirect_to superadmin_root_path
        end
      end
    end

  end

  private

  def number_or_nil(string)
    Integer(string || '')
  rescue ArgumentError
    nil
  end

end
