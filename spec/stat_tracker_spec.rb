require './spec_helper'

RSpec.describe StatTracker do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  describe "initialize" do
    it "exists" do
      expect(@stat_tracker).to be_a(StatTracker)
    end
  end

  describe "high scores" do
    it "highest score" do
      @stat_tracker.highest_total_score
    end
  end
  describe "low scores" do
    it "lowest score" do
      @stat_tracker.lowest_total_score
    end
  end
  describe "percentage home wins" do
    it "percentage home wins" do
      @stat_tracker.percentage_home_wins
    end
  end
  describe "percentage visitor wins" do
    it "percentage visitor wins" do
      @stat_tracker.percentage_visitor_wins
    end
  end

  describe "percentage ties" do
    it "percentage ties" do
      @stat_tracker.percentage_ties
    end
  end
  describe "count of games" do
    it "count of games" do
      @stat_tracker.count_of_games_by_season
    end
  end

  describe "average goals" do
    it "average goals" do
      @stat_tracker.average_goals_per_game
      @stat_tracker.average_goals_by_season
    end
  end

  describe "most accurate team" do
    it "most accurate team" do
      @stat_tracker.team_accuracy(20132014)
      @stat_tracker.most_accurate_team(20132014)
    end
  end

  describe "least accurate team" do
    it "least accurate team" do
      @stat_tracker.team_accuracy(20132014)
      @stat_tracker.least_accurate_team(20132014)
    end
  end

  describe "most tackles" do
    it "most tackles" do
      @stat_tracker.most_tackles(20132014)
    end
  end
  # describe "least tackels" do
  #   it "least tackles" do
  #   end
  # end

  describe "team amount" do
    it "can count the number of teams" do 
      @stat_tracker.count_of_teams
    end
  end
  describe "team offenses and total games" do
    it "can give total games by team" do 
      @stat_tracker.total_games_by_team
    end

    it "can give best offensive team" do 
      @stat_tracker.best_offense
    end

    it "can give worst offensive team" do
      @stat_tracker.worst_offense
    end
  end
  
  describe "team id to team names" do 
    it "has a hash containing team ID keys and team name values" do 
      @stat_tracker.team_id_to_team_name
    end
  end
  

end
