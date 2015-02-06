require "rails_helper"

describe "Players API", :type => :request do

  let(:request_headers) { { "Accept" => "application/json", "Content-type" => "application/json" } }

  it "returns a list of players" do
    FactoryGirl.create_list(:player, 10)

    get "/api/players"

    expect(response).to have_http_status 200

    players = JSON.parse(response.body)
    expect(players.count).to eq(10)
  end

  # it "returns a specific speedboat" do
  #   speedboat = FactoryGirl.create(:speedboat)

  #   get "/api/speedboats/#{speedboat.id}"

  #   expect(response).to have_http_status 200
  #   expect(response.body).to eq(speedboat.to_json)
  # end

  # it "creates a new speedboat" do
  #   speedboat_attributes = { "speedboat" => FactoryGirl.attributes_for(:speedboat) }.to_json

  #   post "/api/speedboats", speedboat_attributes, request_headers

  #   speedboat = JSON.parse(response.body)
  #   expect(response).to have_http_status 200
  #   expect(response.location).to eq("http://www.example.com/api/speedboats/#{speedboat['id']}")
  # end

  # it "does not create a new speedboat with model_number nil" do
  #   speedboat_attributes = { "speedboat" => FactoryGirl.attributes_for(:speedboat, model_number: nil) }.to_json

  #   post "/api/speedboats", speedboat_attributes, request_headers

  #   expect(response).to have_http_status 422
  # end

  # it "updates a specific speedboat" do
  #   speedboat = FactoryGirl.create(:speedboat)
  #   speedboat_attributes = { "speedboat" => { "model_number" => "S1000" } }.to_json

  #   patch "/api/speedboats/#{speedboat.id}", speedboat_attributes, request_headers
  #   # puts response.body
  #   expect(response).to have_http_status 200
  #   expect(speedboat.reload.model_number).to eq("S1000")
  # end

  # it "destroys a specific speedboat" do
  #   speedboat = FactoryGirl.create(:speedboat)

  #   delete "/api/speedboats/#{speedboat.id}"
  #   expect(response).to have_http_status 204
  # end

end