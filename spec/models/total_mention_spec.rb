require 'rails_helper'

RSpec.describe TotalMention, :type => :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:total_mention)).to be_valid
  end


end
