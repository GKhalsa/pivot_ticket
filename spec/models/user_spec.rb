require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end

  describe "associations" do
    it { is_expected.to have_many(:orders) }
    it { is_expected.to have_many(:order_tickets) }
    it { is_expected.to have_many(:tickets) }
  end

  describe "admin" do
    it "should return true when asked if admin" do
      admin = create(:admin)
      expect(admin.admin?).to be(true)
    end

    it "should return false when asked if default user" do
      admin = create(:admin)
      expect(admin.default?).to be(false)
    end
  end

  describe "non admin user" do
    it "should return true when asked if default user" do
      user = create(:user)
      expect(user.default?).to be(true)
    end

    it "should return false when asked if admin" do
      user = create(:user)
      expect(user.admin?).to be(false)
    end
  end

  describe ".self.o_auth_find_or_create_by" do
    scenario "it should find a user who already exists" do
      user = create(:o_auth_user)
      auth_hash = {
        info: {
          email: "user@example.com",
          nickname: "user"
        }
      }
      found_user = User.o_auth_find_or_create_by(auth_hash)
      expect(found_user.name).to eq(user.name)
      expect(found_user.email).to eq(user.email)
    end

    scenario "it should create a user when one does not exist" do
      auth_hash = {
        info: {
          email: "user@example.com",
          nickname: "user"
        }
      }
      User.o_auth_find_or_create_by(auth_hash)
      expect(User.all.count).to eq(1)
    end
  end

  describe ".self.create_user_from" do
    scenario "it should create a user from an auth hash" do
      auth_hash = {
        info: {
          email: "user@example.com",
          nickname: "user"
        }
      }
      User.create_user_from(auth_hash)
      expect(User.all.count).to eq(1)
    end
  end
end
