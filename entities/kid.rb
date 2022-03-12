require_relative "../traits/human_movement"
require_relative "../traits/human_bio"
require_relative "../rave"

class Kid
  include HumanMovement
  include HumanBio

  attr_reader :inventory, :location

  def initialize(inventory:)
    @inventory = inventory
    @candies_consumed = rand(0..2)
    @max_candy_limit = rand(1..9)
    @location = Rave::LOCATIONS.to_a.sample.last
    set_bio_state
  end
end
