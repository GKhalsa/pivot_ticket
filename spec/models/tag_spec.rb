require 'rails_helper'

RSpec.describe Tag, type: :model do
  it { is_expected.to have_many(:ticket_tags) }
  it { is_expected.to have_many(:tickets) }

  it "can search itself for a tag" do
    tag = Tag.create(word: "tag")
    ticket = create(:ticket)
    ticket.tags = [tag]

    result = Tag.search("tag")

    expect(result).to eq([ticket])
  end
end
