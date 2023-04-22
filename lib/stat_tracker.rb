require "csv"

class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(locations)
    @games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    # @game = Game.new(@games_data)
    # @league = League.new(???)
    # @season = Season.new(???)
  end

  def self.from_csv(location)
    StatTracker.new(location)
  end

  def highest_total_score
    @games_data.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end.max
  end

  def lowest_total_score
    @games_data.map do |row|
      row[:away_goals].to_i + row[:home_goals].to_i
    end.min
  end

  def percentage_home_wins
    game_count = 0
    wins = 0
    @game_teams_data.each do |game|
      game_count += 1
      if (game[:hoa] == "home" && game[:result] == "WIN") || (game[:hoa] == "away" && game[:result] == "LOSS")
        wins += 1
      end
    end
    percentage = wins / game_count.to_f
    percentage = percentage.round(2)
  end

  def percentage_visitor_wins
    game_count = 0
    wins = 0
    @game_teams_data.each do |game|
      game_count += 1
      if (game[:hoa] == "away" && game[:result] == "WIN") || (game[:hoa] == "home" && game[:result] == "LOSS")
        wins += 1
      end
    end
    percentage = wins / game_count.to_f
    percentage = percentage.round(2)
  end

  def percentage_ties
    ties = 0
    games = 0
    @game_teams_data.each do |row|
      games += 1
      if row[:result] == "TIE"
        ties += 1
      end
    end
    total = ties.to_f / games
    total.round(2)
  end

  def count_of_games_by_season
    games_by_season = {}
    @games_data.each do |game|
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
    @games_data.each do |game|
      goals_sum = game[:away_goals].to_i + game[:home_goals].to_i
      goals << goals_sum
    end
    total = goals.sum / goals.length.to_f
    total.round(2)
  end

  def count_of_goals_by_season
    goals_by_season = {}
    @games_data.each do |game|
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
  def create_season(season)
    specific_season = []
    @game_teams_data.each do |row|
      specific_season << row if row[:game_id].start_with?(season.to_s[0,4])
    end
    specific_season
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
    team_accuracy(season)
    @teams_data.each do |team|
      if team[:team_id] == @team_accuracies.key(@team_accuracies.values.max)
        return name = team[:teamname]
      end
    end
  end
  def least_accurate_team(season)
    team_accuracy(season)
    @teams_data.each do |team|
      if team[:team_id] == @team_accuracies.key(@team_accuracies.values.min)
        return name = team[:teamname]
      end
    end
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

  # def fewest_tackles(season)
  # end
  
  def count_of_teams
    teams = []
    @game_teams_data.each do |game|
      teams << game[:team_id]
    end
    teams.uniq.length
  end
  def total_goals_by_team
    goals = {}
    @game_teams_data.each do |game|
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
    @game_teams_data.each do |game|
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


end