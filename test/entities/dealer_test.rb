# frozen_string_literal: true

require "minitest/autorun"
require "pry"
require_relative "../../entities/dealer"

class DealerTest < Minitest::Test
  def setup
    @dealer = Dealer.new(inventory: [{cocaine: 10, mdma: 30, pot: 10, paper: 12000}], car: true, weapon: true)
  end

  def test_instance_of_dealer
    assert_instance_of Dealer, @dealer
  end

  def test_starting_location_has_car
    assert_equal :parking_lot, @dealer.location
  end
end
