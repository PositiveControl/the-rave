# frozen_string_literal: true

require "minitest/autorun"
require "pry"
require_relative "../../traits/human_bio"

class Homosapien
  include HumanBio

  def initialize
    @candies_consumed = rand(0..2)
    @max_candy_limit = rand(1..9)
    set_bio_state
  end
end

class HumanBioTest < Minitest::Test
  def setup
    @homosapien = Homosapien.new
  end

  def test_homosapien_consumes_candy
    inital = @homosapien.candies_consumed
    @homosapien.eat_candy!

    refute_equal(inital, @homosapien.candies_consumed)
  end

  def test_homosapien_consumes_multiple_candy
    inital = @homosapien.candies_consumed
    amount_to_eat = 5
    @homosapien.eat_candy!(quantity: amount_to_eat)

    assert_equal(inital + amount_to_eat, @homosapien.candies_consumed)
  end

  def test_max_candy_limit
    killer_candies = @homosapien.max_candy_limit - @homosapien.candies_consumed
    @homosapien.eat_candy!(quantity: killer_candies + 2)

    assert_equal :dead, @homosapien.state
  end

  def test_min_candy_limit
    @homosapien.eat_candy!(quantity: -99)

    assert_equal :straight_edge, @homosapien.state
  end
end
