class Rave
  attr_reader :capacity, :duration, :start_time, :end_time, :max_dealers, :max_security

  DEALER_RATIO = 50
  SECURITY_RATIO = 10
  LOCATIONS = {
    1.0 => :parking_lot,
    2.0 => :the_line,
    3.0 => :security_checkpoint,
    4.0 => :main_room,
    4.1 => :bathroom,
    5.0 => :second_room,
    6.0 => :vip,
    187 => :jail
  }

  def initialize(capacity: 50, duration: 1200, start_time:)
    @capacity = capacity # 50 default
    @duration = duration # 1200 sec / 20 minutes
    @start_time = start_time.utc
    @end_time = Time.at(start_time.to_i + duration).utc
    @max_dealers = @capacity / DEALER_RATIO
    @max_security = @capacity / SECURITY_RATIO
  end
end