# frozen_string_literal: true

class User
  extend ActiveModel::Callbacks
  include ActiveModel::SecurePassword
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string

  define_model_callbacks :create

  has_secure_password
  has_secure_password :recovery_password, validations: false

  attr_accessor :password_digest, :recovery_password_digest
  attr_accessor :password_called

  def password=(unencrypted_password)
    self.password_called ||= 0
    self.password_called += 1
    super
  end
end
