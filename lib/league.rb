class League 
  attr_reader :games_data,
              :game_teams_data,
              :teams_data

  def initialize(games_data, games_teams_data, teams_data)
    @games_data = games_data
    @games_teams_data = games_teams_data
    @teams_data = teams_data
  end

#   highest_scoring_visitor 	Name of the team with the highest average score per game across all seasons when they are away. 	String
# highest_scoring_home_team 	Name of the team with the highest average score per game across all seasons when they are home. 	String

end