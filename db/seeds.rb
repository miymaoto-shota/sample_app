User.create!(name: 'testUser01',
             email: 's.miyamoto@atomitech.jp',
             password: '88884444',
             password_confirmation: '88884444',
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end
