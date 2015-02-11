require 'rails_helper'

RSpec.describe Player, :type => :model do

  let(:player) { create(:player) }
  let(:hour) { Time.now.hour }
  let(:day) { Time.now.day }

  let(:player_with_scores) { create(:player_with_hourly_scores) }

  it "has a valid factory" do
    expect(player).to be_valid
  end

  it "has a valid player_with_hourly_scores_factory" do
    expect(player_with_scores).to be_valid
  end

  it "should create a player with hourly_scores using the player_with_hourly_scores factory" do
    player = create(:player_with_hourly_scores, score_count: 10)
    expect(player.hourly_scores.count).to eq(10)
  end

  it "validates name" do
    player.name = nil

    expect(player).to be_invalid
  end

  it "validates twitter_handle" do
    player.twitter_handle = nil

    expect(player).to be_invalid
  end

  describe "#delete_old_hourly_scores" do

    it "does nothing if there are no hourly scores" do

      player.delete_old_hourly_scores

      expect(player.hourly_scores.count).to eq(0)
    end

    it "deletes a score from 25 hours ago" do
      #BAD hourly score which should be deleted
      player.hourly_scores.push(create(:hourly_score, hour: hour-1, created_at: 1.day.ago))

      player.delete_old_hourly_scores

      expect(player.hourly_scores.count).to eq(0)
    end

    it "deletes a score from 24 hours ago" do
      #BAD hourly score which should be deleted
      player.hourly_scores.push(create(:hourly_score, hour: hour, created_at: 1.day.ago))

      player.delete_old_hourly_scores

      expect(player.hourly_scores.count).to eq(0)
    end

    it "does not delete a score from 23 hours ago" do
      # GOOD hourly score which should not be deleted
      player.hourly_scores.push(create(:hourly_score, hour: hour+1, created_at: 1.day.ago))

      player.delete_old_hourly_scores

      expect(player.hourly_scores.count).to eq(1)
    end

    it "does not remove any hours from today" do
      # GOOD hourly scores that should not be deleted
      player.hourly_scores.push(create(:hourly_score, hour: hour+1, created_at: 1.day.ago))
      player.hourly_scores.push(create(:hourly_score, hour: hour, created_at: Time.now))
      player.hourly_scores.push(create(:hourly_score, hour: hour-5, created_at: 5.hours.ago))

      player.delete_old_hourly_scores

      expect(player.hourly_scores.count).to eq(3)

    end

    it "deletes scores from the future" do
      # BAD scores from the future that should be deleted
      player.hourly_scores.push(create(:hourly_score, hour: hour+1, created_at: 1.hour.from_now))

      player.delete_old_hourly_scores
      expect(player.hourly_scores.count).to eq(0)
    end


  end

end
