require 'rails_helper'

RSpec.describe UserShow, type: :model do
  describe UserShow do
    it { should belong_to :show }
    it { should belong_to :user }
  end
end
