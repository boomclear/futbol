class League 
  attr_reader :games_data,
              :game_teams_data,
              :teams_data

  def initialize(games_data, games_teams_data, teams_data)
    @games_data = games_data
    @games_teams_data = games_teams_data
    @teams_data = teams_data
  end
  
  def count_of_teams
    teams = []
    @games_teams_data.each do |game|
      teams << game[:team_id]
    end
    teams.uniq.length
  end

  def total_goals_by_team
    goals = {}
    @games_teams_data.each do |game|
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
    @games_teams_data.each do |game|
      if !games[game[:team_id]]
        games[game[:team_id]] = 1
      else
        games[game[:team_id]] += 1
      end
    end
    games
  end
  
  def best_offense
    offenses = {}
    total_goals_by_team.each do |team, goals|
      offenses[team] = goals.to_f / total_games_by_team[team]
    end
    best_average = offenses.values.max
    team_id_to_team_name[offenses.key(best_average)]
  end
  
  def worst_offense
    offenses = {}
    total_goals_by_team.each do |team, goals|
      offenses[team] = (goals.to_f / total_games_by_team[team]).round(2)
    end
    best_average = offenses.values.min
    team_id_to_team_name[offenses.key(best_average)]
  end
  
  def team_id_to_team_name
    teams = {}
    @teams_data.each do |team|
      teams[team[:team_id]] = team[:teamname]
    end
    teams
  end
  
  # helper
  def total_home_games_by_team
    home_games = {}
    @games_teams_data.each do |game|
      if game[:hoa] == "home"
        if !home_games[game[:team_id]]
          home_games[game[:team_id]] = 1
        else
          home_games[game[:team_id]] += 1
        end
      end
    end
    home_games
  end

  # helper
  def total_away_games_by_team
    away_games = {}
    @games_teams_data.each do |game|
      if game[:hoa] == "away"
        if !away_games[game[:team_id]]
          away_games[game[:team_id]] = 1
        else
          away_games[game[:team_id]] += 1
        end
      end
    end
    away_games
  end

  #helper
  def total_home_goals_by_team
    home_goals = {}
    @games_teams_data.each do |game|
      if game[:hoa] == "home"
        if !home_goals[game[:team_id]]
          home_goals[game[:team_id]] = game[:goals].to_i
        else
          home_goals[game[:team_id]] += game[:goals].to_i
        end
      end
    end
    home_goals
  end
  
  #helper
  def total_away_goals_by_team
    away_goals = {}
    @games_teams_data.each do |game|
      if game[:hoa] == "away"
        if !away_goals[game[:team_id]]
          away_goals[game[:team_id]] = game[:goals].to_i
        else
          away_goals[game[:team_id]] += game[:goals].to_i
        end
      end
    end
    away_goals
  end

  # calculate_home_goals_average
  def highest_scoring_home_team
    goal_avg = Hash.new(0)

    total_home_games_by_team.each do |team, games|
      goals = total_home_goals_by_team[team] || 0
      avg = (goals.to_f / games.to_f)
      goal_avg[team] = avg.round(2)
    end
    goal_avg
    goal_max = goal_avg.values.max
    team_id_to_team_name[goal_avg.key(goal_max)]
  end
  
  # calculate_away_goals_average
  def highest_scoring_visitor
    goal_avg = Hash.new(0)

    total_away_games_by_team.each do |team, games|
      goals = total_away_goals_by_team[team] || 0
      avg = (goals.to_f / games.to_f)
      goal_avg[team] = avg.round(2)
    end
    goal_avg
    goal_max = goal_avg.values.max
    team_id_to_team_name[goal_avg.key(goal_max)]
  end
  
end