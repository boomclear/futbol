require './spec_helper'

RSpec.describe League do
  before(:each) do
    games_data = CSV.read('./data_dummy/games_dummy.csv', headers: true, header_converters: :symbol)
    games_teams_data = CSV.read('./data_dummy/game_teams_dummy.csv', headers: true, header_converters: :symbol)
    teams_data = CSV.read('./data_dummy/teams_dummy.csv', headers: true, header_converters: :symbol)

    @league = League.new(games_data, games_teams_data, teams_data)
  end

  describe "initialize" do
    it "exists" do
      expect(@league).to be_a(League)
    end
  end

  describe "team amount" do
    it "can count the number of teams" do 
      expect(@league.count_of_teams).to eq(14)
    end
  end
  describe "team offenses and total games" do
    it "can give total games by team" do 
      expected = {
        "3"=>2,
        "6"=>2,
        "5"=>3,
        "17"=>4,
        "16"=>3,
        "9"=>1,
        "8"=>1,
        "30"=>1,
        "26"=>1,
        "19"=>1,
        "24"=>2,
        "2"=>2,
        "52"=>1,
        "28"=>1
      }
      expect(@league.total_games_by_team).to eq(expected)
    end

    it "can give best offensive team" do 
      expect(@league.best_offense).to eq("New York Red Bulls")
    end

    it "can give worst offensive team" do
      expect(@league.worst_offense).to eq("Los Angeles FC")
    end
  end
end