require "rails_helper"

RSpec.describe ItemSender, type: :mailer do
  describe ".send_order" do
    before(:each) do
      @user = create(:user)
      @order = create(:order)
      ItemSender.send_order(@user, @order).deliver_now
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end

    it "should send an email" do
      expect(ActionMailer::Base.deliveries.count).to eq(3)
    end

    it "has the correct receiver email" do
      expect(ActionMailer::Base.deliveries.first.to).to eq([@user.email])
    end

    it "has the correct subject" do
      message = "Here is your Order!"
      expect(ActionMailer::Base.deliveries.first.subject).to eq(message)
    end

    it "has the correct sender email" do
      email = "no-reply@example.com"
      expect(ActionMailer::Base.deliveries.first.from).to eq([email])
    end
  end
end
