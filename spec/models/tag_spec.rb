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

  it "can parse multiple comma separated strings for multiple tags" do
    a = Tag.create(word: "a tag")
    b = Tag.create(word: "tag2")
    c = Tag.create(word: "another tag")

    string = "a tag, tag2, another tag"

    tags = Tag.new_tags(string)

    expect(tags).to eq([a, b, c])
  end
end
