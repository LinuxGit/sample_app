namespace :db do
  desc "fill database with sample data"
  task populate: :environment do
    admin =  User.create!(name: "Daniel Liu",
                 email: "gofaceme@gmail.com",
                 password: "foobar",
                 password_confirmation: "foobar")
    admin.toggle!(:admin)
    99.times do |n|
      name = Faker::Name.name
      email = "gofaceme#{n+1}@gmail.com"
      password = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end
