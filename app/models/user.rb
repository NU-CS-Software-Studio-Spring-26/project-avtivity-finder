class User < ApplicationRecord
  has_secure_password

  has_many :activities, dependent: :destroy

  before_validation :normalize_email

  validates :name, presence: true

  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password,
            length: { minimum: 6 },
            if: -> { password.present? }

  private

  def normalize_email
    self.email = email.to_s.strip.downcase.presence
  end
end
