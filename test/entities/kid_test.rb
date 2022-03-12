# frozen_string_literal: true

require "minitest/autorun"
require "pry"
require_relative "../../entities/kid"

class KidTest < Minitest::Test
  def setup
    @kid = Kid.new(inventory: [{cocaine: 10, mdma: 30, pot: 10, paper: 12000}])
  end

  def test_instance_of_kid
    assert_instance_of Kid, @kid
  end
end
