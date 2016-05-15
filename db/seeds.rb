class Seed

  def initialize
    create_known_users
    # create_sports_venue_event_tickets
    # create_music_venue_event_tickets
  end

  def create_known_users
    users = ["Admin", "Josh", "Andrew", "Jorge", "Jeneve", "Drew", "Sunny"]
    users.each do |user|
      user = User.create(
      email: "#{user.downcase}@turing.io",
      password: "password",
      name: user)
      puts "Created #{user.name}, with email: #{user.email}"
    end
  end

  def create_sports_venue_event_tickets
    sports = Category.create!(name: "Sports")
    5.times do
      sport_venue = Venue.create(name: "#{Faker::University.name} stadium",
                              address: "#{Faker::Address.street_address}, #{Faker::Address.city}, #{Faker::Address.state_abbr}, #{Faker::Address.zip}",
                               status: 1)
      puts "Built #{sport_venue.name} at #{sport_venue.address}"
      10.times do
        team1 = Faker::Team.name
        team2 = Faker::Team.name
        game = Event.create(title: "#{team1} vs. #{team2} at #{sport_venue.name}",
                       performing: "#{team1}, #{team2}",
                             date: Faker::Date.forward(23),
                    # event_image: Faker::Avatar.image,
                      category_id: sports.id,
                         venue_id: sport_venue.id)
        puts "#{game.title} is happening on #{game.date}, at #{game.venue.name}!"
        num_sports_tix = rand(75..200)
        num_sports_tix.times do
          Ticket.create(price: Faker::Commerce.price,
                seat_location: Faker::Lorem.characters(3),
                     event_id: game.id,
                  category_id: sports.id)
        end
        puts "There are #{num_sports_tix} tickets avaliable for #{Ticket.last.event.title} at #{Ticket.last.venue}."
      end
    end
  end

  def create_music_venue_event_tickets
    music = Category.create!(name: "Music")
    5.times do
      music_venue = Venue.create(name: "#{Faker::Company.name} concert hall",
                              address: "#{Faker::Address.street_address}, #{Faker::Address.city}, #{Faker::Address.state_abbr}, #{Faker::Address.zip}",
                               status: 1)
      puts "Built #{music_venue.name} at #{music_venue.address}"
      10.times do
        group = Faker::Superhero.name
        artist = Faker::Name.name
        concert = Event.create(title: "#{artist} with #{group} at #{music_venue.name}",
                       performing: "#{group}, #{artist}",
                             date: Faker::Date.forward(23),
                      # event_image: Faker::Avatar.image,
                      category_id: music.id,
                         venue_id: music_venue.id)
        puts "#{concert.title} is happening on #{concert.date}, at #{concert.venue.name}!"
        num_tix = rand(75..200)
        num_tix.times do
          Ticket.create(price: Faker::Commerce.price,
                seat_location: Faker::Lorem.characters(3),
                     event_id: concert.id,
                  category_id: music.id)
        end
        puts "There are #{num_tix} tickets avaliable for #{Ticket.last.event.title} at #{Ticket.last.venue}."
      end
    end
  end

end

Seed.new
