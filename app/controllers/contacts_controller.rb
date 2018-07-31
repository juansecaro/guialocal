class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      redirect_to root_path, notice: 'Mensaje enviado con éxito'
    else
      flash.now[:alert] = "No se ha podido enviar el mensaje"
      render 'new'
    end
  end
end
