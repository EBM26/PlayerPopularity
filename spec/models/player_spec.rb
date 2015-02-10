require 'rails_helper'

RSpec.describe Player, :type => :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:player)).to be_valid
  end

  it "has a valid player_with_hourly_scores_factory" do
    expect(FactoryGirl.create(:player_with_hourly_scores)).to be_valid
  end

  it "should create a player with hourly_scores using the player_with_hourly_scores factory" do
    player = FactoryGirl.create(:player_with_hourly_scores, score_count: 10)
    expect(player.hourly_scores.count).to eq(10)
  end

end
