# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

if Property.find_by_code(:title).blank?
  Property.create(
    code: :title,
    value: 'Title',
    description: 'Title'
  )
end

if User.find_by_email('admin@mail.com').blank?
  User.create!(
    email: 'admin@mail.com',
    password: '123456789',
    password_confirmation: '123456789',
    superadmin: true
  )
end

if Property.find_by_code(:chat_id).blank?
  Property.create(
    code: :chat_id,
    value: '12345',
    description: 'The Id of telegram chat'
  )
end

if Property.find_by_code(:admin_chat_id).blank?
  Property.create(
    code: :admin_chat_id,
    value: '12345',
    description: "The Id of admin's telegram chat"
  )
end
