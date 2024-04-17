require "rails_helper"

RSpec.describe Ride, type: :model do
  describe "relationships" do
    it { should have_many(:rides) }
  end
end
