# frozen_string_literal: true

require_relative "../traits/human_movement"
require_relative "../traits/human_bio"
require_relative "../rave"

class Dealer
  include HumanMovement
  include HumanBio

  attr_reader :inventory, :sales, :fails, :car, :weapon, :location

  def initialize(inventory:, car:, weapon:)
    @inventory = inventory
    @sales = 0
    @fails = 0
    @car = car
    @weapon = weapon
    @location = car? ? Rave::LOCATIONS[1.0] : Rave::LOCATIONS[2.0]
  end

  def car?
    !@car.nil?
  end
end
