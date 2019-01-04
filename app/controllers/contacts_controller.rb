class ContactsController < ApplicationController
  invisible_captcha only: :create, honeypot: :subtitle, on_spam: :spam_received
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
  
  private
  def spam_received
    redirect_to root_path
  end
end
