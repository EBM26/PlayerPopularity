require 'rails_helper'

RSpec.describe HourlyScore, :type => :model do

  it "has a valid factory" do
    expect(create(:hourly_score)).to be_valid
  end

end
