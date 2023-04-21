class League 
  attr_reader :league_data
  
  def initialize(data)
    @league_data = data
  end
  
  def count_of_teams
    teams = []
    @league_data.each do |game|
      teams << game[:team_id]
    end
    teams.uniq.length
  end

  def total_goals_by_team
    goals = {}
    @league_data.each do |game|
      if !goals[game[:team_id]]
        goals[game[:team_id]] = game[:goals].to_i
      else
        goals[game[:team_id]] += game[:goals].to_i
      end
    end
    goals
  end

  def total_games_by_team
    games = {}
    @league_data.each do |game|
      if !games[game[:team_id]]
       games[game[:team_id]] = 1
      else
       games[game[:team_id]] += 1
      end
    end
    games
  end

  def best_offence
    offenses = {}
    total_goals_by_team.each do |team, goals|
      offenses[team] = goals.to_f / total_games_by_team[team]
    end
    best_average = offenses.values.max
    offenses.key(best_average)
  end

  def worst_offence
    offenses = {}
    total_goals_by_team.each do |team, goals|
      offenses[team] = (goals.to_f / total_games_by_team[team]).round(2)
    end
    best_average = offenses.values.min
    offenses.key(best_average)
  end

end