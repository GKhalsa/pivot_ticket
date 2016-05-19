require "rails_helper"

RSpec.describe ItemSender, type: :mailer do
  describe ".send_order" do
    before(:each) do
      @before_count = ActionMailer::Base.deliveries.count
      @user = create(:user)
      @order = create(:order)
      ItemSender.send_order(@user, @order).deliver_now
      @after_count = ActionMailer::Base.deliveries.count
    end

    after(:each) do
      ActionMailer::Base.deliveries.clear
    end

    it "should send an email" do
      expect(@after_count).to eq(@before_count + 1)
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
