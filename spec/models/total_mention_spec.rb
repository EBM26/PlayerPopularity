require 'rails_helper'

RSpec.describe TotalMention, :type => :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:total_mention)).to be_valid
  end

  # it "has a valid customer_with_speedboat_factory" do
  #   expect(FactoryGirl.create(:customer_with_speedboats)).to be_valid
  # end

  # it "should create a customer with speedboats using the customer_with_speedboats factory" do
  #   customer = FactoryGirl.create(:customer_with_speedboats, boat_count: 2)
  #   expect(customer.speedboats.count).to eq(2)
  # end

end
