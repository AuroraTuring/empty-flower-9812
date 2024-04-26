require "rails_helper"

RSpec.describe "Mechanic Show Page", type: :feature do
  before(:each) do
    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
    @universal = AmusementPark.create!(name: 'Universal Studios', admission_cost: 80)

    @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
    @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
    @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)

    @jaws = @universal.rides.create!(name: 'Jaws', thrill_rating: 5, open: true)

    @mechanic1 = Mechanic.create!(name: 'Lisa', years_experience: 10)
    @mechanic2 = Mechanic.create!(name: 'Frank', years_experience: 13)

    @mechanic_ride1 = MechanicRide.create!(mechanic_id: @mechanic1.id, ride_id: @scrambler.id)
    @mechanic_ride2 = MechanicRide.create!(mechanic_id: @mechanic1.id, ride_id: @jaws.id)
    @mechanic_ride3 = MechanicRide.create!(mechanic_id: @mechanic2.id, ride_id: @ferris.id)
  end

  describe "when I visit a mechanic show page" do
    it "sees their name, years of experience, and names of all rides they are working on" do
      visit "/mechanics/#{@mechanic1.id}"

      expect(page).to have_content("Mechanic Name: #{@mechanic1.name}")
      expect(page).to have_content("Years Experience: #{@mechanic1.years_experience}")
      expect(page).to_not have_content("Mechanic Name: #{@mechanic2.name}")
      expect(page).to_not have_content("Years Experience: #{@mechanic2.years_experience}")

      within ".mechanic-rides" do
        expect(page).to have_content("Rides Working On:")
        expect(page).to have_content("#{@scrambler.name}")
        expect(page).to have_content("#{@jaws.name}")
        expect(page).to_not have_content("#{@hurler.name}")
      end
    end
  end
end
