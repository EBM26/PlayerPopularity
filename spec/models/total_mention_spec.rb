require 'rails_helper'

RSpec.describe TotalMention, :type => :model do

  let(:hour) { Time.now.hour }
  let(:day) { Time.now.day }

  it "has a valid factory" do
    expect(create(:total_mention)).to be_valid
  end

  describe "#create_missing_hours" do

    # Needs fixing
    # it "creates 24 empty total_mentions if there are no total_mentions" do
    #   TotalMention.create_missing_hours

    #   expect(TotalMention.count).to eq(24)
    # end

    # Needs fixing
    # it "creates only the missing total_mentions if some already exist" do
    #   create(:total_mention, hour: 5, total_mentions: 50)
    #   create(:total_mention, hour: 20, total_mentions: 80)

    #   TotalMention.create_missing_hours

    #   expect(TotalMention.count).to eq(24)

    #   hour5 = TotalMention.find_by(hour: 5)
    #   hour20 = TotalMention.find_by(hour: 20)

    #   expect(hour5.total_mentions).to eq(50)
    #   expect(hour20.total_mentions).to eq(80)
    # end

  end

  describe "#delete_old_hours" do

    it "does nothing if the total mentions are all from the last 24 hours" do
      mention = create(:total_mention, hour: hour+1, created_at: 1.day.ago)
      mention1 = create(:total_mention, hour: hour, created_at: Time.now)

      # puts "Now Day: #{day}, hour: #{hour}"
      # puts "Day: #{mention.created_at.yday}, Hour: #{mention.hour}"

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
