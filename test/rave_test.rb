# frozen_string_literal: true

require "minitest/autorun"
require "pry"
require_relative "../rave"

class RaveTest < Minitest::Test
  def setup
    @capacity = 555
    @rave = Rave.new(capacity: @capacity, start_time: Time.now.utc)
  end

  def test_instance_of_rave
    assert_instance_of Rave, @rave
  end

  def test_rave_has_a_capacity
    assert_instance_of Integer, @rave.capacity
  end

  def test_rave_capacity_can_be_set
    assert_equal @capacity, @rave.capacity
  end

  def test_dealer_ratio
    max = @capacity / Rave::DEALER_RATIO
    assert_equal max, @rave.max_dealers
  end

  def test_security_ratio
    max = @capacity / Rave::SECURITY_RATIO
    assert_equal max, @rave.max_security
  end

  def test_time_attributes
    assert_instance_of Time, @rave.start_time
    assert_instance_of Time, @rave.end_time
    assert_instance_of Integer, @rave.duration
  end
end