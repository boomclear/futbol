require "csv"

class Game 
  attr_reader :game_data

  def initialize(data)
    @game_data = data
  end

  def highest_total_score
    @game_data.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end.max
  end

  def lowest_total_score
    @game_data.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end.min
  end
  
  def percentage_home_wins
    game_count = 0
    wins = 0
    @game_data.each do |game|
      game_count += 1
      if game[:home_goals].to_i > game[:away_goals].to_i
        wins += 1
      end
    end
    percentage = wins / game_count.to_f
    percentage = percentage.round(2)
  end

  def percentage_visitor_wins
    game_count = 0
    wins = 0
    @game_data.each do |game|
      game_count += 1
      if game[:home_goals].to_i < game[:away_goals].to_i
        wins += 1
      end
    end
    percentage = wins / game_count.to_f
    percentage = percentage.round(2)
  end

  def percentage_ties
    games = 0
    ties = 0
    @game_data.each do |row|
      if row[:away_goals].to_i == row[:home_goals].to_i
        ties += 1
      elsif row[:away_goals].to_i != row[:home_goals].to_i
        games += 1
      end
    end
    (ties.to_f / (games + ties)).round(2)
  end

  def count_of_games_by_season
    games_by_season = {}
    @game_data.each do |game|
      if games_by_season[game[:season]].nil?
        games_by_season[game[:season]] = 1
      else
        games_by_season[game[:season]] += 1
      end
    end
    games_by_season
  end

  def average_goals_per_game
    goals = []
    @game_data.each do |game|
      goals_sum = game[:away_goals].to_i + game[:home_goals].to_i
      goals << goals_sum
    end
    (goals.sum / goals.length.to_f).round(2)
  end

  def count_of_goals_by_season
    goals_by_season = {}
    @game_data.each do |game|
      if goals_by_season[game[:season]].nil?
        goals_by_season[game[:season]] = game[:home_goals].to_i + game[:away_goals].to_i
      else
        goals_by_season[game[:season]] += game[:home_goals].to_i + game[:away_goals].to_i
      end
    end
    goals_by_season
  end

  def average_goals_by_season
    average_goals = {}
    count_of_goals_by_season.each do |season, goals|
      average_goals[season] = (goals.to_f / count_of_games_by_season[season]).round(2)
    end
    average_goals
  end

end 
