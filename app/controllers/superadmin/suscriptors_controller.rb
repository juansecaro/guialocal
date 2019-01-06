class Superadmin::SuscriptorsController < Superadmin::ApplicationController
  def index
    @suscriptors = Suscriptor.all
  end
  
  def show

  end
end
