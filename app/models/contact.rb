class Contact < MailForm::Base
  attribute :name, :validate => true
  attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message,   :validate => true
  attribute :nickname,  :captcha  => true
  attr_accessor :subtitle

  def headers
    {
      :subject => "Contacto desde Guia#{$current_city}",
      :to => "info@adeter.org",
      :from => %("#{name}" <#{email}>)
    }
  end
end
