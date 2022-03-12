# frozen_string_literal: true

require "minitest/autorun"
require "pry"
require_relative "../../traits/human_movement"

class Entity
  include HumanMovement
  attr_reader :location

  def initialize
    @location = :parking_lot
  end
end

class HumanMovementTest < Minitest::Test
  def setup
    @entity = Entity.new
  end

  def test_moving_to_adjacent_location
    assert_equal :parking_lot, @entity.location
    assert @entity.move_to(:the_line)
    assert_equal :the_line, @entity.location
  end

  def test_moving_to_non_adjacent_location
    # can't skip the line
    assert_equal :parking_lot, @entity.location
    refute @entity.move_to(:security_checkpoint)
    assert_equal :parking_lot, @entity.location
  end

  def test_moving_everywhere
    assert_equal :parking_lot, @entity.location
    assert @entity.move_to(:the_line)
    assert @entity.move_to(:security_checkpoint)
    assert @entity.move_to(:main_room)
    assert @entity.move_to(:bathroom)

    refute @entity.move_to(:parking_lot)
    refute @entity.move_to(:security_checkpoint)
    refute @entity.move_to(:second_room)

    assert_equal :bathroom, @entity.location
    assert @entity.move_to(:main_room)
    assert_equal :main_room, @entity.location

    refute @entity.move_to(:vip)
    refute @entity.move_to(:the_line)

    assert @entity.move_to(:second_room)
    assert_equal :second_room, @entity.location

    refute @entity.move_to(:bathroom)

    assert_equal :second_room, @entity.location
    assert @entity.move_to(:main_room)
    assert_equal :main_room, @entity.location
  end
end
