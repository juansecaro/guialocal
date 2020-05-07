class Prospect < ApplicationRecord

  enum original_plan: [:noplan, :basic, :plus, :premium]

  VALID_DNI_REGEX = /((([X-Z])|([LM])){1}([-]?)((\d){7})([-]?)([A-Z]{1}))|((\d{8})([-]?)([A-Z]))/.freeze
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  VALID_IBAN_REGEX = /([a-zA-Z]{2})\s*\t*(\d{2})\s*\t*(\d{4})\s*\t*(\d{4})\s*\t*(\d{2})\s*\t*(\d{10})/i.freeze

  validates :dni, presence: true, format: { with: VALID_DNI_REGEX }, if: :sign_up?
  validates :user_email, presence: true, format: { with: VALID_EMAIL_REGEX }, if: :sign_up?
  validates :user_phone, presence: true, if: :sign_up?
  validates :user_first_name, presence: true, if: :sign_up?
  validates :user_last_name, presence: true, if: :sign_up?

  validates :empresa_name, presence: true, if: :business_details?
  validates :empresa_address, presence: true, if: :business_details?
  validates :empresa_phone, presence: true, if: :business_details?
  validates :empresa_summary, presence: true, if: :business_details?

  validates :user_address, presence: true, if: :user_details?
  validates :conditions_accepted, acceptance: true, if: :user_details?
  validates :iban_code, presence: true, format: { with: VALID_IBAN_REGEX },  if: :user_details?

  def sign_up?
    status == 'sign_up'
  end

  def business_details?
    status == 'business_details'
  end

  def user_details?
    status == 'user_details'
  end
end
