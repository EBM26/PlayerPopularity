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

  it "show returns a specific player" do
    player = create(:player)

    get "/api/players/#{player.id}"

    expect(response).to have_http_status 200
    expect(response.body).to eq(player.to_json(include: :hourly_scores))
  end

  it "show returns an error if player is not in DB" do
    get "/api/players/-1"

    expected_response = {status: 404, message: "Player with ID -1 could not be found"}

    expect(response.body).to eq(expected_response.to_json)
  end

  it "index returns all players" do
    player = create(:player)
    player2 = create(:player)

    get "/api/players"

    expect(response).to have_http_status 200
    expect(response.body).to eq(Player.all.to_json)
  end

  describe ".current_scores" do

    it "returns the most recent hourly score for each player" do
      player = create(:player_with_hourly_scores, score_count: 1, name: "kobe")
      player2 = create(:player_with_hourly_scores, score_count: 5, name: "lebron")

      player.hourly_scores.create(score: 15)
      player2.hourly_scores.create(score: 500)

      get "/api/players/current_scores"

      expected_response = [
        {name: "kobe", score: 15.0, hour: nil},
        {name: "lebron", score: 500.0, hour: nil}
        ]

      expect(response).to have_http_status 200
      expect(response.body).to eq(expected_response.to_json)
    end

  end

  describe ".hourly_scores" do

    it "returns all hourly scores for each player" do
      player = create(:player_with_hourly_scores, score_count: 3, name: "kobe")
      player2 = create(:player_with_hourly_scores, score_count: 3, name: "lebron")

      get "/api/players/hourly_scores"

      expected_response = [
        {
          name: "kobe",
          scores: 
          [
            {hour:0,score:0.0},
            {hour:0,score:0.0},
            {hour:0,score:0.0}
          ]
        },
        {
          name: "lebron",
          scores: 
          [
            {hour:0,score:0.0},
            {hour:0,score:0.0},
            {hour:0,score:0.0}
          ]
        }
      ]

      expect(response).to have_http_status 200
      expect(response.body).to eq(expected_response.to_json)

    end

  end

  describe ".top_five" do

    it "returns only the current leading 5 players and their hourly scores" do
      player1 = create(:player_with_hourly_scores, score_count: 1, name: "p1", current_mentions: 50)
      player2 = create(:player_with_hourly_scores, score_count: 1, name: "p2", current_mentions: 45)
      player3 = create(:player_with_hourly_scores, score_count: 1, name: "p3", current_mentions: 30)
      player4 = create(:player_with_hourly_scores, score_count: 1, name: "p4", current_mentions: 20)
      player5 = create(:player_with_hourly_scores, score_count: 1, name: "p5", current_mentions: 19)
      player6 = create(:player_with_hourly_scores, score_count: 1, name: "p6", current_mentions: 15)
      player7 = create(:player_with_hourly_scores, score_count: 1, name: "p7", current_mentions: 0)

      get "/api/players/top_five"

      expected_response =
        [
          {
          name: "p1",
          scores: [hour:0, score: 0.0],
          current_mentions: 50
          },
          {
          name: "p2",
          scores: [hour:0, score: 0.0],
          current_mentions: 45
          },
          {
          name: "p3",
          scores: [hour:0, score: 0.0],
          current_mentions: 30
          },
          {
          name: "p4",
          scores: [hour:0, score: 0.0],
          current_mentions: 20
          },
          {
          name: "p5",
          scores: [hour:0, score: 0.0],
          current_mentions: 19
          }
        ]

        expect(response).to have_http_status 200
        expect(response.body).to eq(expected_response.to_json)

    end

  end







end