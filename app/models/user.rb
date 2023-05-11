class User < ApplicationRecord
  acts_as_paranoid

  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :customer, dependent: :destroy
  has_one :account_request

  accepts_nested_attributes_for :customer

  scope :with_role, ->(role) { joins(:roles).where('roles.name = ?', role.to_s) }
  scope :employee, -> { with_role(:employee) }
  scope :customer, -> { with_role(:customer) }

  def admin?
    self.has_role?(:admin)
  end

  def employee?
    self.has_role?(:employee)
  end
end
