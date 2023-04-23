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

  def total_games_by_team_hoa(status)
    games = {}
    @games_teams_data.each do |game|
      if game[:hoa] == status
        if !games[game[:team_id]]
          games[game[:team_id]] = 1
        else
          games[game[:team_id]] += 1
        end
      end
    end
    games
  end

  def total_goals_by_team_hoa(status)
    goals = {}
    @games_teams_data.each do |game|
      if game[:hoa] == status
        if !goals[game[:team_id]]
          goals[game[:team_id]] = game[:goals].to_i
        else
          goals[game[:team_id]] += game[:goals].to_i
        end
      end
    end
    goals
  end

  def highest_scoring_home_team
    goal_avg = Hash.new(0)

    total_games_by_team_hoa("home").each do |team, games|
      goals = total_goals_by_team_hoa("home")[team] || 0
      avg = (goals.to_f / games.to_f)
      goal_avg[team] = avg.round(2)
    end
    goal_avg
    goal_max = goal_avg.values.max
    team_id_to_team_name[goal_avg.key(goal_max)]
  end

  def highest_scoring_visitor
    goal_avg = Hash.new(0)

    total_games_by_team_hoa("away").each do |team, games|
      goals = total_goals_by_team_hoa("away")[team] || 0
      avg = (goals.to_f / games.to_f)
      goal_avg[team] = avg.round(2)
    end
    goal_avg
    goal_max = goal_avg.values.max
    team_id_to_team_name[goal_avg.key(goal_max)]
  end
  
  def lowest_scoring_home_team
    goal_avg = Hash.new(0)

    total_games_by_team_hoa("home").each do |team, games|
      goals = total_goals_by_team_hoa("home")[team] || 0
      avg = (goals.to_f / games.to_f)
      goal_avg[team] = avg.round(2)
    end
    goal_avg
    goal_min = goal_avg.values.min
    team_id_to_team_name[goal_avg.key(goal_min)]
  end

  def lowest_scoring_visitor
    goal_avg = Hash.new(0)

    total_games_by_team_hoa("away").each do |team, games|
      goals = total_goals_by_team_hoa("away")[team] || 0
      avg = (goals.to_f / games.to_f)
      goal_avg[team] = avg.round(2)
    end
    goal_avg
    goal_min = goal_avg.values.min
    team_id_to_team_name[goal_avg.key(goal_min)]
  end
end