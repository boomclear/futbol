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

end