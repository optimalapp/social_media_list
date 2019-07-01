social_networks = ["facebook", "twitter"]

first_list_name = Faker::Team.name
list = List.create(name: first_list_name)

10.times do
  user_name = Faker::Name.name
  user = list.users.create(name: user_name)
  second_list_name = Faker::Team.name
  user.lists.create(name: second_list_name)
  social_networks.each do |network|
    user.lists.each do |list|
      account = user.accounts.create(social_network: network)
      10.times do
        link = Faker::Internet.url
        date = Faker::Time.between(7.days.ago, Date.today, :all)
        text = Faker::Lorem.paragraph
        account.posts.create(link: link, date_posted: date, text: text)
      end
    end
  end
end
