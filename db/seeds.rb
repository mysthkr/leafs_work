# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

name = "admin"
email = "admin@gmail.com"
password = "password"
User.create!(name: name,
            email: email,
            password: password,
            admin: true
            )

9.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               )
end

10.times do |n|
  task_name = "Task#{n}"
  task_detail = Faker::Games::Pokemon.name
  status = "ToDo"
  priority = "High"
  user_id = n + 1
  Task.create!(task_name: task_name,
               task_detail: task_detail,
               status: status,
               priority: priority,
               user_id: user_id
               )
end

10.times do |n|
  name = "Label#{n}"
  Label.create!(name: name
               )
end
