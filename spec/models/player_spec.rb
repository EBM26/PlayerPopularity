require 'rails_helper'

RSpec.describe Player, :type => :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:player)).to be_valid
  end

  # it "has a valid customer_with_speedboat_factory" do
  #   expect(FactoryGirl.create(:customer_with_speedboats)).to be_valid
  # end

  # it "should create a customer with speedboats using the customer_with_speedboats factory" do
  #   customer = FactoryGirl.create(:customer_with_speedboats, boat_count: 2)
  #   expect(customer.speedboats.count).to eq(2)
  # end

end
