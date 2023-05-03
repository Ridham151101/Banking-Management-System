class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :customer
  has_one :account_request

  scope :employee, -> { where(User.with_role(:employee)) }
  scope :customer, -> { where(User.with_role(:customer)) }
end
