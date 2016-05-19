require_relative "seeds_helper/image_getter"
require_relative "seeds_helper/address_getter"

class Seed
  include ImageGetter
  include AddressGetter

  def initialize
    create_roles
    create_known_users
    assign_roles
    create_sports_venue_event_tickets
    create_music_venue_event_tickets
    create_users_with_orders
    create_tags
    create_tagged_tickets
  end

  def create_roles
    puts "Creating Roles"
    roles = ["registered_user", "business_admin", "platform_admin"]
    roles.each do |role|
      Role.create(name: role)
      puts role
    end
  end

  def create_roles
    puts "Creating Roles"
    roles = ["registered_user", "business_admin", "platform_admin"]
    roles.each do |role|
      Role.create(name: role)
      puts role
    end
  end

  def create_known_users
    users = ["platform_admin", "business_admin", "user", "Josh", "Andrew", "Jorge", "Jeneve", "Drew", "Sunny"]
    users.each do |user|
      user = User.create(
      email: "#{user.downcase}@turing.io",
      password: "password",
      name: user)
      puts "Created #{user.name}, with email: #{user.email}"
    end
  end

  def assign_roles
    p_a = Role.find_by(name: "platform_admin")
    b_a = Role.find_by(name: "business_admin")
    r_u = Role.find_by(name: "registered_user")
    user = User.find_by(name: "platform_admin")
    user.roles = [p_a]
    puts "#{user.name} has #{user.roles.count} roles"
    user = User.find_by(name: "business_admin")
    user.roles = [b_a]
    puts "#{user.name} has #{user.roles.count} roles"
    user = User.find_by(name: "user")
    user.roles = [r_u]
    puts "#{user.name} has #{user.roles.count} roles"
    user = User.find_by(name: "Josh")
    user.roles = [p_a, b_a, r_u]
    puts "#{user.name} has all #{user.roles.count} roles"
    user = User.find_by(name: "Andrew")
    user.roles = [p_a, b_a, r_u]
    puts "#{user.name} has all #{user.roles.count} roles"
    user = User.find_by(name: "Jorge")
    user.roles = [p_a, b_a, r_u]
    puts "#{user.name} has all #{user.roles.count} roles"
    user = User.find_by(name: "Drew")
    user.roles = [p_a, b_a, r_u]
    puts "#{user.name} has all #{user.roles.count} roles"
    user = User.find_by(name: "Sunny")
    user.roles = [p_a, b_a, r_u]
    puts "#{user.name} has all #{user.roles.count} roles"
    user = User.find_by(name: "Jeneve")
    user.roles = [p_a, b_a, r_u]
    puts "#{user.name} has all #{user.roles.count} roles"
  end

  def create_sports_venue_event_tickets
    sports = Category.create!(name: "Sports")
    10.times do |i|
      sport_venue = Venue.create(name: "#{Faker::University.name} Stadium",
                              address: SPORTS_VENUE_ADDRESSES[i%10],
                               status: i%3,
                                image: get_image("stadium", i))
      user = User.create(name: "#{sport_venue.name} admin",
                        email: "#{sport_venue.name}@turing.io",
                     password: "password",
                     venue_id: sport_venue.id)
      user.roles = [Role.find_by(name: "business_admin")]
      puts "Built #{sport_venue.name} at #{sport_venue.address} admin: #{sport_venue.users.first.name}"
      5.times do |i|
        team1 = Faker::Team.name.capitalize
        team2 = Faker::Team.name.capitalize
        game = Event.create(title: "#{team1} vs. #{team2} at #{sport_venue.name}",
                       performing: "#{team1}, #{team2}",
                             date: Faker::Date.forward(23),
                    event_image: get_image("athlete", i),
                      category_id: sports.id,
                         venue_id: sport_venue.id)
        puts "#{game.title} is happening on #{game.date}, at #{game.venue.name}!"
        num_sports_tix = rand(50..75)
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
    10.times do |i|
      music_venue = Venue.create(name: "#{Faker::Company.name} Concert Hall",
                              address: MUSIC_VENUE_ADDRESSES[i%10],
                               status: i%3,
                                image: get_image("concert", i))
      user = User.create(name: "#{music_venue.name} admin",
                        email: "#{music_venue.name}@turing.io",
                     password: "password",
                     venue_id: music_venue.id)
      user.roles = [Role.find_by(name: "business_admin")]
      puts "Built #{music_venue.name} at #{music_venue.address} admin: #{music_venue.users.first.name}"
      5.times do |i|
        group = Faker::Superhero.name
        artist = Faker::Name.name
        concert = Event.create(title: "#{artist} with #{group} at #{music_venue.name}",
                       performing: "#{group}, #{artist}",
                             date: Faker::Date.forward(23),
                      event_image: get_image("musician", i),
                      category_id: music.id,
                         venue_id: music_venue.id)

        puts "#{concert.title} is happening on #{concert.date}, at #{concert.venue.name}!"
        num_tix = rand(50..75)
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

  def create_users_with_orders
    puts "starting user count- #{User.count}"
    puts "creating user with orders"
    100.times do
      user = User.create(name: Faker::Name.name,
                        email: Faker::Internet.email,
                     password: "password")
      user.roles = [Role.find_by(name: "registered_user")]
      10.times do
        order = Order.create(user_id: user.id)
        2.times do
          ticket = Ticket.create(event_id: Event.first.id,
                              category_id: Event.first.category_id,
                                    price: Faker::Commerce.price,
                            seat_location: Faker::Lorem.characters(3),
                                  user_id: user.id
                                  )
          OrderTicket.create(ticket_id: ticket.id,
                              order_id: order.id)
        end
      end
    end
    puts "created #{Order.count} orders, with #{OrderTicket.count} tickets"
    puts "ending user count-#{User.count}"
  end

  def create_tags
    50.times do
      tag = Tag.create!(word: Faker::Team.sport)
    end
  end

  def create_tagged_tickets
    200.times do
      TicketTag.create!(
      ticket: Ticket.find(rand(1..Ticket.count)),
      tag: Tag.find(rand(1..Tag.count))
      )
    end
  end

end

Seed.new
