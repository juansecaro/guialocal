# frozen_string_literal: true

class User < ApplicationRecord
  enum role: [:user, :editor, :admin, :superadmin]
  after_initialize :set_default_role, if: :new_record?

  has_many :empresas, dependent: :destroy
  has_one :achievement, dependent: :destroy
  has_many :incidents, dependent: :destroy
  has_many :comments, dependent: :destroy

  accepts_nested_attributes_for :achievement, allow_destroy: true

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
