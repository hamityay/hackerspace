# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  puts 'Creating seed data ...'
    Admin.create(email: "admin@hackerspace.com", name: 'Admin', surname: 'Admin', password: '12341234', password_confirmation: '12341234')

  1.upto(9) do |i|
    Card.create(id: "0000000#{i}")
  end

  puts 'Created seed data ...'