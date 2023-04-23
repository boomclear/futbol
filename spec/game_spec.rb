require  './spec_helper'

RSpec.describe Game do
  before(:each) do
    game_path = './data_dummy/games_dummy.csv'
    games_data = CSV.read(game_path, headers: true, header_converters: :symbol)
    @game = Game.new(games_data)

    game_path2 = './data_dummy/game_teams_dummy.csv'
    games_data2 = CSV.read(game_path2, headers: true, header_converters: :symbol)
    @game2 = Game.new(games_data2)
  end
  
  describe "initialize" do
    it "exists" do
      expect(@game).to be_a(Game)
    end
  end
  
  describe "highest_total_score" do
    it "can find the highest sum of the winning and losing teams' scores" do
      expect(@game.highest_total_score).to eq(11)
    end
  end
  
  describe "lowest_total_score" do
    it "can find the lowest sum of the winning and losing teams' scores" do
      expect(@game.lowest_total_score).to eq(0)
    end
  end
  
  describe "win percentages" do
    before(:each) do
      game_path2 = './data_dummy/game_teams_dummy.csv'
      games_data2 = CSV.open(game_path2, headers: true, header_converters: :symbol)
      @game2 = Game.new(games_data2)
    end
    it "returns home win percentages" do
      expect(@game2.percentage_home_wins).to eq(68.00)
    end

    it "returns away win percentages" do
      expect(@game2.percentage_visitor_wins).to eq(28.00)
    end
  end

  describe "percent tie games" do
    it "can add games and divide by number games result in tie" do
      expect(@game.percentage_ties).to eq(0.1)
    end
  end
  
  describe "count of games by season"do
    it "can count games by season" do 
      expected = { 
        "20122013" => 15,
        "20132014" => 5
      }
      expect(@game.count_of_games_by_season).to eq(expected)
    end
  end

  describe "average goals per game" do 
    it "can find average goals per game" do 
      expect(@game.average_goals_per_game).to eq(3.95)
    end
  end

  describe "goals and games by season" do
    it "can count the goals by season" do
      expected = { "20122013" => 58,
      "20132014" => 21 }
      expect(@game.count_of_goals_by_season).to eq(expected)
    end 
  end

  it "can give average goals by season" do 
    expected = {
    "20122013" => 3.87,
    "20132014" => 4.20
    }
    expect(@game.average_goals_by_season).to eq(expected)
  end
end

