FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
    password "password"
    name "Jon"

    factory :admin do
      sequence :email do |n|
        "admin#{n}@example.com"
      end
    end

    factory :o_auth_user do
      email "user@example.com"
      name "user"
      password "00000"
    end
  end


  factory :venue do
    sequence :name do |n|
      "Venue_#{n} Name"
    end
    address "Venue Address"
    status 0
    slug "test-slug"
  end

  factory :event do
    sequence :title do |n|
      "Event_#{n} Title"
    end
    performing "Event Performer"
    date Date.today
    venue
  end


  factory :ticket do
    event
    sequence :seat_location do |n|
      n.to_s
    end
    price 9.99
    factory :retired_ticket do
    end
  end

  factory :order do
    user

    factory :paid_order do
      status 1
    end

    factory :cancelled_order do
      status 2
    end

    factory :completed_order do
      status 3
    end
  end

  factory :order_ticket do
    ticket
    order
    quantity 1
  end
end
