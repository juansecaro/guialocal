class Admin::ApplicationController < ApplicationController
before_action :authorize_admin!

  def index
    @users = User.all
    @empresas = Empresa.all
    @categories = Category.all
  end

  private
  def authorize_admin!
    authenticate_user!
    unless current_user.admin?
      redirect_to root_path, alert: "Tú no eres administrador."
    end
  end
end
