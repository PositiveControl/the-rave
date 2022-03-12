require_relative "../traits/human_movement"
require_relative "../rave"

class Kid
  include HumanMovement
  attr_reader :inventory, :weapon, :location, :candies_consumed

  def initialize(inventory:)
    @inventory = inventory
    @candies_consumed = rand(0..3)
    @location = Rave::LOCATIONS.to_a.sample.last
  end
end
