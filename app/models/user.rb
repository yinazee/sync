class User < ApplicationRecord
  has_one :host
  has_one :guest
  has_secure_password

end
