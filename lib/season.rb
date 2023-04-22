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

  def most_tackles(season)
    team_tackle_totals = Hash.new(0)

    create_season(season).each do |row|
      team_tackle_totals[row[:team_id]] += row[:tackles].to_i
    end
    
    team_most_tackles_id = team_tackle_totals.max_by do |team_id, tackles|
      tackles
    end

    get_team_name(team_most_tackles_id[0])
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
    @teams_data.each do |team|
      if team[:team_id] == @team_accuracies.key(@team_accuracies.values.max)
        return name = team[:teamname]
      end
    end
  end
  
  def least_accurate_team(season)
    @teams_data.each do |team|
      if team[:team_id] == @team_accuracies.key(@team_accuracies.values.min)
        return name = team[:teamname]
      end
    end
  end
  
  def coach_record(season)
    coach_wins = Hash.new(0)
    coach_losses = Hash.new(0)
    @coach_record = Hash.new
    create_season(season).each do |row|
      if row[:result] == "WIN"
        wins = coach_wins[row[:head_coach]] += 1
      # elsif row[:result] == "LOSS"
      #   losses = coach_losses[row[:head_coach]] += 1
      # end
      win_percentage = wins.to_f /
      head_coach = row[:head_coach]
      @coach_record[head_coach] = win_percentage
    end
  end

  def winningest_coach(season)
    @games_teams_data.each do |coach|
      if coach[:head_coach] == @coach_record.key(@coach_record.values.max)
        return coach = coach[:head_coach]
      end
    end
  end
end