class Season 
  attr_reader :games_data,
              :game_teams_data,
              :teams_data
  
  def initialize(games_data, games_teams_data, teams_data)
    @games_data = games_data
    @games_teams_data = games_teams_data
    @teams_data = teams_data
  end

  def create_season(season)
    specific_season = []
    @games_teams_data.each do |row|
      specific_season << row if row[:game_id].start_with?(season.to_s[0,4])
    end
    specific_season
  end

  def get_team_name(team_id)
    @teams_data.each do |row|
      return row[:teamname] if row[:team_id] == team_id
    end
  end

  def get_tackles(season)
    team_tackle_totals = Hash.new(0)

    create_season(season).each do |row|
      team_tackle_totals[row[:team_id]] += row[:tackles].to_i
    end
    team_tackle_totals
  end

  def most_tackles(season)
    team_most_tackles = get_tackles(season).max_by { |team_id, tackles| tackles }
    get_team_name(team_most_tackles[0])
  end

  def fewest_tackles(season)
    team_fewest_tackles = get_tackles(season).min_by { |team_id, tackles| tackles }
    get_team_name(team_fewest_tackles[0])
  end

  def worst_coach(season)
    num_games_coached = Hash.new(0)
    num_games_won = Hash.new(0)

    create_season(season).each do |row|
      num_games_coached[row[:head_coach]] += 1
      num_games_won[row[:head_coach]] +=1 if row[:result] == "WIN"
    end

    win_percentage = calculate_win_percentage(num_games_won, num_games_coached)

    worst_coach = win_percentage.min_by do |coach, win_percent|
      win_percent
    end
    worst_coach[0]
  end

  def calculate_win_percentage(num_games_won, num_games_coached)
    win_percentage = Hash.new(0)

    num_games_coached.each do |coach, games_coached|
      games_won = num_games_won[coach] || 0
      percentage = (games_won.to_f / games_coached.to_f) * 100
      win_percentage[coach] = percentage.round(2)
    end
    win_percentage
  end

  def team_accuracy(season)
    team_shots_total = Hash.new(0)
    team_goals_total = Hash.new(0)
    @team_accuracies = Hash.new
    create_season(season).each do |row|
      shots = team_shots_total[row[:team_id]] += row[:shots].to_i
      goals = team_goals_total[row[:team_id]] += row[:goals].to_i
      team_accuracy = goals / shots.to_f
      team_id = row[:team_id]
      @team_accuracies[team_id] = team_accuracy
    end
  end
  
  def most_accurate_team(season)
    teams = CSV.read('./data_dummy/teams_dummy.csv', headers: true, header_converters: :symbol)
    teams.each do |team|
      if team[:team_id] == @team_accuracies.key(@team_accuracies.values.max)
        return name = team[:teamname]
      end
    end
  end
  
  def least_accurate_team(season)
    teams = CSV.read('./data_dummy/teams_dummy.csv', headers: true, header_converters: :symbol)
    teams.each do |team|
      if team[:team_id] == @team_accuracies.key(@team_accuracies.values.min)
        return name = team[:teamname]
      end
    end
  end

end