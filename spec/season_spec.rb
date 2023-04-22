require './spec_helper'

RSpec.describe Season do
  before(:each) do
    games_data = CSV.read('./data_dummy/games_dummy.csv', headers: true, header_converters: :symbol)
    games_teams_data = CSV.read('./data_dummy/game_teams_dummy.csv', headers: true, header_converters: :symbol)
    teams_data = CSV.read('./data_dummy/teams_dummy.csv', headers: true, header_converters: :symbol)

    @season = Season.new(games_data, games_teams_data, teams_data)
  end

  describe "initialize" do
    it "exists" do
      expect(@season).to be_a(Season)
    end
  end

  describe "create_season" do
    it "can create an array with the data from only one specific season included" do
      season_2012 = @season.create_season(20122013)
      season_2013 = @season.create_season(20132014)
      season_2014 = @season.create_season(20142015)
      expect(season_2012.first[:team_id]).to eq("3")
      expect(season_2012.last[:result]).to eq("WIN")
      expect(season_2013.first[:shots]).to eq("5")
      expect(season_2014.first[:tackles]).to eq("61")
    end
  end
  
  describe "get_team_name" do 
    it "can get the team name from the corresponding team_id number" do
      expect(@season.get_team_name("1")).to eq("Atlanta United")
      expect(@season.get_team_name("24")).to eq("Real Salt Lake")
      expect(@season.get_team_name("53")).to eq("Columbus Crew SC")
    end
  end

  describe "most_tackles" do
    it "can determine the team with the most tackles in a season" do
      expect(@season.most_tackles(20122013)).to eq("LA Galaxy")
      expect(@season.most_tackles(20132014)).to eq("New England Revolution")
      expect(@season.most_tackles(20142015)).to eq("Portland Thorns FC")
    end
  end


  describe "team accuracy" do
    it "returns most accurate team" do
      expect(@season.team_accuracy(20122013))
      expect(@season.most_accurate_team(20122013)).to eq("New York Red Bulls")
      expect(@season.least_accurate_team(20122013)).to eq("Seattle Sounders FC")
    end
  end
  
  describe "winningest coach" do
    it "returns most accurate team" do
      @season.coach_record(20122013)
      require 'pry'; binding.pry
      expect(@season.winningest_coach(20122013)).to eq("Claude Julien")
    end
  end

end