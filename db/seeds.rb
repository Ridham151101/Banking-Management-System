# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create roles
admin_role = Role.find_or_create_by(name: 'admin')
employee_role = Role.find_or_create_by(name: 'employee')
customer_role = Role.find_or_create_by(name: 'customer')

# Create admin user
admin = User.create(name: 'Ridham', email: 'ridham.patel@bacancy.com', password: '123456', password_confirmation: '123456')
admin.add_role(:admin)