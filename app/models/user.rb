class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :customer
  has_one :account_request

  scope :with_role, ->(role) { joins(:roles).where('roles.name = ?', role.to_s) }
  scope :employee, -> { with_role(:employee) }
  scope :customer, -> { with_role(:customer) }
end
