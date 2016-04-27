require 'rails_helper'

RSpec.describe UserArtist, type: :model do
  describe UserArtist do
    it { should belong_to :artist }
    it { should belong_to :user }
  end
end
