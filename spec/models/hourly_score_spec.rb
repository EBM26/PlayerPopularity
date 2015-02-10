require 'rails_helper'

RSpec.describe HourlyScore, :type => :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:hourly_score)).to be_valid
  end

end
