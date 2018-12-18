class Suscriptor < ApplicationRecord
  before_create :confirmation_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }

  def confirmation_token
        if self.token_confirmation.blank?
            self.token_confirmation = SecureRandom.urlsafe_base64.to_s
        end
  end

end
