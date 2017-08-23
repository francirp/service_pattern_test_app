class User < ApplicationRecord
  validates :email, :name, :age, presence: true
end
