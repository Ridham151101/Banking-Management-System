require 'rails_helper'

RSpec.describe User, type: :model do
  describe "associations" do
    it { is_expected.to have_one(:customer).dependent(:destroy) }
    it { is_expected.to have_one(:account_request) }
    it { is_expected.to have_many(:employee_transactions) }
  end

  describe "validations" do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe "roles" do
    let(:user) { create(:user) }

    it "should have an admin role" do
      user.add_role(:admin)
      expect(user).to have_role(:admin)
      expect(user.admin?).to be true
    end

    it "should have an employee role" do
      user.add_role(:employee)
      expect(user).to have_role(:employee)
      expect(user.employee?).to be true
    end

    it "should have a customer role" do
      user.add_role(:customer)
      expect(user).to have_role(:customer)
      expect(user.customer?).to be true
    end
  end

  describe 'scopes' do
    let!(:admin_user) { create(:user) }
    let!(:employee_user) { create(:user) }
    let!(:customer_user) { create(:user) }

    before do
      admin_user.add_role(:admin)
      employee_user.add_role(:employee)
      customer_user.add_role(:customer)
    end

    describe '.employee' do
      it 'should return users with employee roles' do
        expect(User.employee).to include(employee_user)
        expect(User.employee).not_to include(admin_user, customer_user)
      end
    end

    describe '.customer' do
      it 'should return users with customer roles' do
        expect(User.customer).to include(customer_user)
        expect(User.customer).not_to include(admin_user, employee_user)
      end
    end
  end
end
