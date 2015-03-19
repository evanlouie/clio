10.times do |t|
  Team.create(name: Faker::Company.name)
end
200.times do |n|
  User.create(:email => "user#{n}@goclio.com",
              :first_name => Faker::Name.first_name,
              :last_name => Faker::Name.last_name,
              :password => "testtest",
              :password_confirmation => "testtest",
              :status => [:in, :out].sample,
              :web_site => Faker::Internet.url,
              :team_id => Team.first(offset: rand(Team.count)).id
              )

end
User.create(email: 'mail@evanlouie.com', first_name: 'Evan', last_name: 'Louie', password: 'password', password_confirmation: 'password', status: 'in', web_site: 'http://evanlouie.com', team_id: Team.first(offset: rand(Team.count)).id)
