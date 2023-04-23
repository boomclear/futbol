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
  
  describe "team id to team names" do 
    it "has a hash containing team ID keys and team name values" do 
      expected = {
        "1"=>"Atlanta United",
        "4"=>"Chicago Fire",
        "26"=>"FC Cincinnati",
        "14"=>"DC United",
        "6"=>"FC Dallas",
        "3"=>"Houston Dynamo",
        "5"=>"Sporting Kansas City",
        "17"=>"LA Galaxy",
        "28"=>"Los Angeles FC",
        "18"=>"Minnesota United FC",
        "23"=>"Montreal Impact",
        "16"=>"New England Revolution",
        "9"=>"New York City FC",
        "8"=>"New York Red Bulls",
        "30"=>"Orlando City SC",
        "15"=>"Portland Timbers",
        "19"=>"Philadelphia Union",
        "24"=>"Real Salt Lake",
        "27"=>"San Jose Earthquakes",
        "2"=>"Seattle Sounders FC",
        "20"=>"Toronto FC",
        "21"=>"Vancouver Whitecaps FC",
        "25"=>"Chicago Red Stars",
        "13"=>"Houston Dash",
        "10"=>"North Carolina Courage",
        "29"=>"Orlando Pride",
        "52"=>"Portland Thorns FC",
        "54"=>"Reign FC",
        "12"=>"Sky Blue FC",
        "7"=>"Utah Royals FC",
        "22"=>"Washington Spirit FC",
        "53"=>"Columbus Crew SC"
      }
      expect(@league.team_id_to_team_name).to eq(expected)
    end
  end

  describe "Overall highest and lowest scorers when home and away" do
      it "can find home games" do 
        home_games = {
        "16"=>3, 
        "17"=>1, 
        "19"=>1, 
        "24"=>1, 
        "5"=>2, 
        "52"=>1, 
        "6"=>2, 
        "8"=>1
      }
      expect(@league.total_games_by_team_hoa("home")).to eq(home_games)
    end

    it "can find home goals" do 
      home_goals = {
        "16"=>7, 
        "17"=>2, 
        "19"=>2, 
        "24"=>2, 
        "5"=>4, 
        "52"=>2, 
        "6"=>4, 
        "8"=>3}
        expect(@league.total_goals_by_team_hoa("home")).to eq(home_goals)
    end

    it "can find highest home goals/games average" do 
      expect(@league.highest_scoring_home_team).to eq("New York Red Bulls")
    end
    
    it "can find lowest home goals/games average" do 
      expect(@league.lowest_scoring_home_team).to eq("FC Dallas")
    end

    it "can find away games" do 
      away_games = {
      "17"=>3, 
      "2"=>2, 
      "24"=>1, 
      "26"=>1, 
      "28"=>1, 
      "3"=>2, 
      "30"=>1, 
      "5"=>1, 
      "9"=>1
      }
      expect(@league.total_games_by_team_hoa("away")).to eq(away_games)
    end

    it "can find away goals" do 
    away_goals = {
      "17"=>5, 
      "2"=>2, 
      "24"=>2, 
      "26"=>1, 
      "28"=>0, 
      "3"=>4, 
      "30"=>1, 
      "5"=>0, 
      "9"=>2}
      expect(@league.total_goals_by_team_hoa("away")).to eq(away_goals)
    end

    it "can find highest away goals/games avg" do 
      expect(@league.highest_scoring_visitor).to eq("Houston Dynamo")
    end

    it "can find lowest away goals/games avg" do 
      expect(@league.lowest_scoring_visitor).to eq("Los Angeles FC")
    end
  end
  

end