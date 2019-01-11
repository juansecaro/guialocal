class Suscriptor < ApplicationRecord
  belongs_to :empresa, optional: true

  before_create :confirmation_token
  attr_accessor :subtitle

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }

  def confirmation_token
      if self.token_confirmation.blank?
          self.token_confirmation = SecureRandom.urlsafe_base64.to_s
      end
  end

end
