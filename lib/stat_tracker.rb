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
  
end