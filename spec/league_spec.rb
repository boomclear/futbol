require './spec_helper'

RSpec.describe League do
  before(:each) do
    game_path = './data_dummy/games_dummy.csv'
    games_data = CSV.read(game_path, headers: true, header_converters: :symbol)
    @league = League.new(games_data)

    game_teams_path = './data_dummy/game_teams_dummy.csv'
    games_teams_data = CSV.read(game_teams_path, headers: true, header_converters: :symbol)
    @league2 = League.new(games_teams_data)

    teams_path = './data_dummy/teams_dummy.csv'
    teams_data = CSV.read(teams_path, headers: true, header_converters: :symbol)
    @league3 = League.new(teams_data)
  end

  describe "initialize" do
    it "exists" do
      expect(@league).to be_a(League)
    end
  end

  describe "team amount" do
    it "can count the number of teams" do 
      expect(@league2.count_of_teams).to eq(14)
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
      expect(@league2.total_games_by_team).to eq(expected)
    end

    it "can give best offensive team" do 
      expect(@league2.best_offence).to eq("8")
    end

    it "can give worst offensive team" do
      expect(@league2.worst_offence).to eq("28")
    end
  end
end