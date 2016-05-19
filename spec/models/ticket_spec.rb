require "rails_helper"

RSpec.describe Ticket, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:seat_location) }
    it { is_expected.to validate_uniqueness_of(:seat_location).scoped_to(:event_id).with_message("that ticket has already been posted for sale") }
  end

  it "can get the name of the venue from the ticket" do
    venue = create(:venue)
    event = create(:event, venue_id: venue.id)
    ticket = create(:ticket, event_id: event.id)

    expect(ticket.venue_name).to eq(venue.name)
  end
end
