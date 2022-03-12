module HumanBio
  # Classes including HumanBio can use the following attributes
  attr_reader :candies_consumed, :max_candy_limit, :state

  STATES = {
    0.0 => :straight_edge,
    1.0 => :soberish,
    2.0 => :buzzing,
    3.0 => :dancing_bafoon,
    4.0 => :rolling,
    5.0 => :cuddle_puddle,
    6.0 => :frying,
    7.0 => :blank_slate,
    8.0 => :awaiting_ambulance,
    9.0 => :probably_dead,
    10.0 => :dead
  }.freeze

  def eat_candy!(quantity: 1)
    @candies_consumed += quantity
    set_bio_state
  end

  private

  def set_bio_state
    @state = STATES[fucked_up_factor]
  end

  def fucked_up_factor
    ((@candies_consumed.to_f / @max_candy_limit.to_f) * 10.0).floor.to_f.tap do |fuf|
      return 0.0 if fuf <= 0
      return 10.0 if fuf >= 10
    end
  end
end
