# frozen_string_literal: true

require "minitest/autorun"
require "pry"
require_relative "../../entities/kid"

class KidTest < Minitest::Test
  def setup
    @kid = Kid.new(inventory: [{mdma: 1, pot: 1, paper: 100}])
  end

  def test_instance_of_kid
    assert_instance_of Kid, @kid
  end
end
