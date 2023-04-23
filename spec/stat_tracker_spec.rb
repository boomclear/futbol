require './spec_helper'

RSpec.describe StatTracker do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    
    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe "initialize" do
    it "exists" do
      expect(@stat_tracker).to be_a(StatTracker)
    end
    it 'has data' do
        expect(@stat_tracker.games_data).to eq(@games_data)
        expect(@stat_tracker.teams_data).to eq(@teams_data)
        expect(@stat_tracker.game_teams_data).to eq(@games_teams_data)
    end

  end

  describe "highest_total_score" do
    it "can determine highest sum of the winning and losing teams' scores" do
      expect(@stat_tracker.highest_total_score).to eq 11
    end
  end

  describe "lowest_total_score" do
    it "can determine lowest sum of the winning and losing teams' scores" do
      expect(@stat_tracker.lowest_total_score).to eq 0
    end
  end

  describe "percentage_home_wins" do
    it "can determine the percentage of games that a home team has won" do
      expect(@stat_tracker.percentage_home_wins).to eq 0.44
    end
  end

  describe "percentage_visitor_wins" do
    it "can determine the percentage of games that a visitor team has won" do
      expect(@stat_tracker.percentage_visitor_wins).to eq 0.36
    end
  end

  describe "percentage_ties" do
    it "can determine the percentage of games that has resulted in a tie" do
      expect(@stat_tracker.percentage_ties).to eq 0.20
    end
  end

  describe "count_of_games_by_season" do
    it "can return a hash with season name => count of games" do
      expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
      }
      expect(@stat_tracker.count_of_games_by_season).to eq expected
    end
  end

  describe "average_goals_per_game" do
    it "can return the average num of goals scored in a game" do
      expect(@stat_tracker.average_goals_per_game).to eq 4.22
    end
  end
  
  describe "average_goals_by_season" do
    it "can return the average num of goals by season" do
      expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
      }
      expect(@stat_tracker.average_goals_by_season).to eq expected
    end
  end

  describe "count_of_teams" do 
    it "can count the total # of teams" do
      expect(@stat_tracker.count_of_teams).to eq 32
    end
  end

  describe "best_offense" do 
    it "can determine the team with the highest average num of goals scored" do
      expect(@stat_tracker.best_offense).to eq "Reign FC"
    end
  end

  describe "worst_offense" do 
    it "can determine the team with the lowest average num of goals scored" do
      expect(@stat_tracker.worst_offense).to eq "Utah Royals FC"
    end
  end

  describe "highest_scoring_visitor" do 
    it "can determine the team with the highest average score per game when away" do
      expect(@stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
    end
  end

  describe "highest_scoring_home_team" do 
    it "can determine the team with the highest average score per game when home" do
      expect(@stat_tracker.highest_scoring_home_team).to eq "Reign FC"
    end
  end

  describe "lowest_scoring_visitor" do 
    it "can determine the team with the lowest average score per game when away" do
      expect(@stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
    end
  end

  describe "lowest_scoring_home_team" do 
    it "can determine the team with the lowest average score per game when home" do
      expect(@stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
    end
  end

  describe "winningest_coach(season)" do
    it "can determine the coach with the best win percentage for a season" do 
      expect(@stat_tracker.winningest_coach("20132014")).to eq "Claude Julien"
      expect(@stat_tracker.winningest_coach("20142015")).to eq "Alain Vigneault"
    end
  end

  describe "worst_coach(season)" do
    it "can determine the coach with the worst win percentage for a season" do 
      expect(@stat_tracker.worst_coach("20132014")).to eq "Peter Laviolette"
      expect(@stat_tracker.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
    end
  end

  describe "most_accurate_team(season)" do
    it "can determine the team with the best ratio of shots to goals for a season" do 
      expect(@stat_tracker.most_accurate_team("20132014")).to eq "Real Salt Lake"
      expect(@stat_tracker.most_accurate_team("20142015")).to eq "Toronto FC"
    end
  end

  describe "least_accurate_team(season)" do
    it "can determine the team with the worst ratio of shots to goals for a season" do 
      expect(@stat_tracker.least_accurate_team("20132014")).to eq "New York City FC"
      expect(@stat_tracker.least_accurate_team("20142015")).to eq "Columbus Crew SC"
    end
  end

  describe "most_tackles(season)" do
    it "can determine the team with the most tackles in a season" do 
      expect(@stat_tracker.most_tackles("20132014")).to eq "FC Cincinnati"
      expect(@stat_tracker.most_tackles("20142015")).to eq "Seattle Sounders FC"
    end
  end

  describe "fewest_tackles(season)" do
    it "can determine the team with the least tackles in a season" do 
      expect(@stat_tracker.fewest_tackles("20132014")).to eq "Atlanta United"
      expect(@stat_tracker.fewest_tackles("20142015")).to eq "Orlando City SC"
    end
  end
end
