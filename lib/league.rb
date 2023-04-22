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

  def team_goals_home
    home = Hash.new(0)
    @games_teams_data.each do |game|
      if game[:HoA] == "home"
        home[game[:team_id]] += game[:goals].to_i
      end
    end
    home
  end
  
  def team_goals_away
    away = Hash.new(0)
    @games_teams_data.each do |game|
      if game[:HoA] == "away"
        away[game[:team_id]] += game[:goals].to_i
      end
    end
    away
  end

  def highest_scoring_home_team
    home_team = {}
    team_goals_home.each do |team, goals|
      home[team] = goals.to_f
    end
    best_home_score = home.values.max
    team_id_to_team_name[home_team.key(best_average)]
  end
  
  def highest_scoring_visitor
    away_team = {}
    team_goals_away.each do |team, goals|
      away[team] = goals.to_f
    end
    best_away_score = away.values.max
    team_id_to_team_name[away_team.key(best_average)]
  end
end