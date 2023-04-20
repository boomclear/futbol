require './spec_helper'

RSpec.describe StatTracker do
  before(:each) do
    @game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    @locations = {
      games: @game_path,
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

  describe "game" do
    it "exists" do
      game = Game.new(@game_path)
      expect(game).to be_a(Game)
      require 'pry'; binding.pry
    end
  end

end
