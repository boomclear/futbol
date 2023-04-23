require "csv"
require_relative "game"
require_relative "league"
require_relative "season"

class StatTracker
  attr_reader :games, :teams, :game_teams, :game, :league, :game_teams_data

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

  # expect(@stat_tracker.percentage_home_wins).to eq 0.44
  def percentage_home_wins
    @game.percentage_home_wins
  end

  # expect(@stat_tracker.percentage_visitor_wins).to eq 0.36
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

  # expect(@stat_tracker.count_of_teams).to eq 32
  def count_of_teams
    @league.count_of_teams
  end

  # expect(@stat_tracker.best_offense).to eq "Reign FC"
  def best_offense
    @league.best_offense
  end

  # expect(@stat_tracker.worst_offense).to eq "Utah Royals FC"
  def worst_offense
    @league.worst_offense
  end

  # expect(@stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
  def highest_scoring_visitor
    @league.highest_scoring_visitor
  end

  # expect(@stat_tracker.highest_scoring_home_team).to eq "Reign FC"
  def highest_scoring_home_team
    @league.highest_scoring_home_team
  end

  # expect(@stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
  def lowest_scoring_visitor
    @league.lowest_scoring_visitor
  end

  # expect(@stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
  def lowest_scoring_home_team
    @league.lowest_scoring_home_team
  end

  # expect(@stat_tracker.winningest_coach("20132014")).to eq "Claude Julien"
  # expect(@stat_tracker.winningest_coach("20142015")).to eq "Alain Vigneault"
  def winningest_coach(season)
    @season.winningest_coach(season)
  end

  # expect(@stat_tracker.worst_coach("20132014")).to eq "Peter Laviolette"
  # expect(@stat_tracker.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
  def worst_coach(season)
    @season.worst_coach(season)
  end

  # expect(@stat_tracker.most_accurate_team("20132014")).to eq "Real Salt Lake"
  # expect(@stat_tracker.most_accurate_team("20142015")).to eq "Toronto FC"
  def most_accurate_team(season)
    @season.most_accurate_team(season)
  end

  # expect(@stat_tracker.least_accurate_team("20132014")).to eq "New York City FC"
  # expect(@stat_tracker.least_accurate_team("20142015")).to eq "Columbus Crew SC"
  def least_accurate_team(season)
    @season.least_accurate_team(season)
  end

  # expect(@stat_tracker.most_tackles("20132014")).to eq "FC Cincinnati"
  # expect(@stat_tracker.most_tackles("20142015")).to eq "Seattle Sounders FC"
  def most_tackles(season)
    @season.most_tackles(season)
  end

  # expect(@stat_tracker.fewest_tackles("20132014")).to eq "Atlanta United"
  # expect(@stat_tracker.fewest_tackles("20142015")).to eq "Orlando City SC"
  def fewest_tackles(season)
    @season.fewest_tackles(season)
  end
end