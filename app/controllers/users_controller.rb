class UsersController < ApplicationController
  after_action :set_empresa, only: :create


  private

  def set_user
  @user = User.friendly.find(params[:id])
  end

  def set_empresa
    user = User.last
    empresa = user.build_empresa
    user.empresa_id = empresa.id
    byebug
    user.save!
  end
end
