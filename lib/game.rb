require "csv"

class Game 
  attr_reader :game_data

  def initialize(data)
    @game_data = data
  end

  def game_count
    game_count = 0
   @game_data.each do |row|
      game_count += 1
    end
    game_count
  end
  # 14882 includes TIEs
  
  
  def percentage_home_wins
    wins = 0

   @game_data.each do |game|
      if game[:hoa] == "home" && game[:result] == "WIN" || game[:hoa] == "away" && game[:result] == "LOSS"
        wins += 1
      end
    end
    percentage = wins / game_count.to_f
    percentage = percentage * 100
    percentage = percentage.round(2)
    require 'pry'; binding.pry
  end

  def percentage_away_wins
    wins = 0
    
   @game_data.each do |game|
      if game[:hoa] == "away" && game[:result] == "WIN" || game[:hoa] == "home" && game[:result] == "LOSS"
        wins += 1
      end
    end
    percentage = wins / game_count.to_f
    percentage = percentage * 100
    percentage = percentage.round(2)
  end
end
