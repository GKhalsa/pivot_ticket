User.create!(
  email: "admin@example.com",
  password: "password",
  name: "Admin",
  role: 1
)
User.create!(
  email: "jeneve@example.com",
  password: "password",
  name: "Jeneve",
  role: 1
)
User.create!(
  email: "sunny@example.com",
  password: "password",
  name: "Sunny",
  role: 1
)
User.create!(
  email: "drew@example.com",
  password: "password",
  name: "Drew",
  role: 1
)

sports = Category.create!(name: "Sports")

mile_high = Venue.create!(name: "Mile High Stadium",
           address: "1 Mile High Way")

game = Event.create!(title: "Broncos vs. the Patriots!",
                performing: "Denver Broncos",
                      date: "5874897 AD",
               category_id: sports.id,
                  venue_id: mile_high.id)

Ticket.create!(price: 50.00,
       seat_location: "45F",
            event_id: game.id,
         category_id: sports.id)
Ticket.create!(price: 350.00,
       seat_location: "BoxA1",
            event_id: game.id,
         category_id: sports.id)


music = Category.create!(name: "Music")

oph = Venue.create!(name: "Ophelia's",
          address: "1 Colorado BLVD")

concert = Event.create!(title: "Surf Legend Dick Dale!",
               performing: "Dick Dale",
                     date: "5874897 AD",
              category_id: music.id,
                 venue_id: oph.id)

Ticket.create!(price: 20.00,
      seat_location: "GA",
           event_id: concert.id,
        category_id: music.id)
Ticket.create!(price: 30.00,
      seat_location: "GA",
           event_id: concert.id,
        category_id: music.id)
