require_relative "../rave"

module HumanMovement
  def move_to(location)
    return false unless adjacent_location?(location)

    @location = location
    true
  end

  private

  def adjacent_location?(destination)
    desired_destination = Rave::LOCATIONS.key(destination)
    current_location = Rave::LOCATIONS.key(@location)
    return false unless desired_destination && current_location

    lower_bound = current_location.floor
    upper_bound = lower_bound + 1
    if current_location > lower_bound
      desired_destination == lower_bound
    elsif desired_destination < lower_bound
      lower_bound - 1 == desired_destination
    else
      desired_destination.between?(lower_bound, upper_bound)
    end
  end
end