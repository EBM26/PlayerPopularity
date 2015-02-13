require 'rails_helper'

RSpec.describe TotalMention, :type => :model do

  let(:hour) { Time.now.hour }
  let(:day) { Time.now.day }

  it "has a valid factory" do
    expect(create(:total_mention)).to be_valid
  end

  describe "#create_missing_hours" do

    it "creates an empty total_mention for each hour between 12AM and the current hour if they're missing" do
      TotalMention.create_missing_hours

      expected_count = Time.now.hour + 1

      expect(TotalMention.count).to eq(expected_count)
    end

    it "creates only the missing total_mentions if some already exist" do

      current_hour = Time.now.hour
      expected_count = current_hour + 1

      create(:total_mention, hour: current_hour, total_mentions: 50)

      TotalMention.create_missing_hours

      expect(TotalMention.count).to eq(expected_count)

      check_hour = TotalMention.find_by(hour: current_hour)

      expect(check_hour.total_mentions).to eq(50)
    end

  end

  describe "#delete_old_hours" do

    it "does nothing if the total mentions are all from the last 24 hours" do
      mention = create(:total_mention, hour: hour+1, created_at: 1.day.ago)
      mention1 = create(:total_mention, hour: hour, created_at: Time.now)

      TotalMention.delete_old_hours

      expect(TotalMention.count).to eq(2)
    end

    it "removes total_mentions that are more than 24 hours old" do

      create(:total_mention, hour: hour, created_at: 1.day.ago)

      TotalMention.delete_old_hours

      expect(TotalMention.count).to eq(0)
    end
  end

end
