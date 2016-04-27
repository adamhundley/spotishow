require 'rails_helper'

RSpec.describe User, type: :model do
  describe User do
    it { should have_many :user_shows }
    it { should have_many :user_artists }
    it { should have_many :artists }
    it { should have_many :shows }
    it { should validate_presence_of :uid }
    it { should validate_uniqueness_of :uid }
  end
end
