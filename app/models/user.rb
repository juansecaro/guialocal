class User < ApplicationRecord

  enum role: [:user, :editor, :admin, :superadmin]
  after_initialize :set_default_role, :if => :new_record?

  has_one :empresa
  has_many :incidents
  has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable


  def set_default_role
    self.role ||= :user
  end


  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


end
