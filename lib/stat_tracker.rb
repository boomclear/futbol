require "csv"
require_relative "game"
require_relative "league"
require_relative "season"

class StatTracker
  attr_reader :games_data, :teams_data, :game_teams_data, :game, :league, :season

  def initialize(locations)
    @games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)

    @game = Game.new(@games_data)
    @league = League.new(@games_data, @games_teams_data, @teams_data)
    @season = Season.new(@games_data, @games_teams_data, @teams_data)
  end

  def self.from_csv(location)
    StatTracker.new(location)
  end

  def highest_total_score
    @game.highest_total_score
  end

  def lowest_total_score
    @game.lowest_total_score
  end

  def percentage_home_wins
    @game.percentage_home_wins
  end

  def percentage_visitor_wins
    @game.percentage_visitor_wins
  end

  def percentage_ties
    @game.percentage_ties
  end

  def count_of_games_by_season
    @game.count_of_games_by_season
  end

  def average_goals_per_game
    @game.average_goals_per_game
  end

  def average_goals_by_season
    @game.average_goals_by_season
  end

  def count_of_teams
    @league.count_of_teams
  end

  def best_offense
    @league.best_offense
  end

  def worst_offense
    @league.worst_offense
  end

  def highest_scoring_visitor
    @league.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @league.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @league.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @league.lowest_scoring_home_team
  end

  def winningest_coach(season)
    @season.winningest_coach(season)
  end

  def worst_coach(season)
    @season.worst_coach(season)
  end

  def most_accurate_team(season)
    @season.most_accurate_team(season)
  end

  def least_accurate_team(season)
    @season.least_accurate_team(season)
  end

  def most_tackles(season)
    @season.most_tackles(season)
  end

  def fewest_tackles(season)
    @season.fewest_tackles(season)
  end
end