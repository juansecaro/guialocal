class Superadmin::UsersController < Superadmin::ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.order(:email)
  end

  def show
    @proposals = AchievementProposal.all
  end

  def edit
    @proposals = AchievementProposal.all
  end

  def update
    if @user.update(users_params)
      flash[:notice] = "Usuario actualizado"
      redirect_to superadmin_users_path
    else
      flash.now[:alert] = "Hubo un problema. No se pudo actualizar la información del usuario."
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash.alert = "Usuario borrado"
    redirect_to superadmin_users_path

  end

  private

  def set_user
    @user = User.find(params[:id])
  end
  def users_params
    params.require(:user).permit(:email, :empresa_id, :role, :first_name, :last_name, :birthdate, :dni, :phone, :address, :gender, achievement_attributes: [:achievement1, :achievement2, :achievement3, :achievement4, :achievement5, :achievement6, :achievement7, :achievement8, :achievement9, :achievement0, :_destroy])
  end
end
