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
      role 1
    end

    factory :o_auth_user do
      email "user@example.com"
      name "user"
      password "00000"
    end
  end


  factory :ticket do
    # sequence :status do |n|
    #   n
    # end
    price 9.99
    # image_path "example.jpg"

    factory :retired_ticket do
      # sequence :status do |n|
      #   n
      # end
    end
  end

  factory :order do
    user

    # factory :paid_order do
    #   status 1
    # end
    #
    # factory :cancelled_order do
    #   status 2
    # end
    #
    # factory :completed_order do
    #   status 3
    # end
  end

  factory :order_ticket do
    ticket
    order
    quantity 1
  end
end
