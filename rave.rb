class Rave
  attr_reader :capacity, :duration, :start_time, :end_time, :max_dealers, :max_security,
  :available_tickets, :ticket_cost, :event_safe
  # Maybe the constants DEALER_RATIO and SECURITY_RATIO should be variables unique
  # to each instance?  Could create some interesting scenarios, high risk, high reward.
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

  def initialize(start_time:, deposit_wallet:, capacity: 50, duration: 1200, ticket_cost: 25)
    @capacity = capacity # 50 default
    @duration = duration # 1200 sec / 20 minutes
    @start_time = start_time.utc
    @end_time = Time.at(start_time.to_i + duration).utc
    @max_dealers = @capacity / DEALER_RATIO
    @max_security = @capacity / SECURITY_RATIO
    @dealers = 0
    @security = 0
    @ticket_cost = ticket_cost
    @available_tickets = @max_dealers
    @event_safe = fund_event_safe(deposit_wallet: deposit_wallet)
  end

  def buy_ticket(payment_wallet:, quantity: 1, type: :general_admission)
    return false if sold_out?

    case type
    when :general_admission
      return false if @available_tickets - quantity < 0
      # Intentionally janky and verbose - rewrite, rethink
      # record the inital balance (we aren't exactly addressing double-spend)
      inital_balance = payment_wallet.balance
      # can they afford it?
      order_total = @ticket_cost * quantity
      return false if order_total > inital_balance
      # if they can, charge it and decrement the tickets
      @available_tickets -= quantity
      # return the difference of initial_balance and ticket_cost to the wallet
      payment_wallet.balance = inital_balance - order_total
      # deposit the difference between the initial balance and ending balance
      @event_safe += inital_balance - payment_wallet.balance
      true
    when :vip
    else
    end
  end

  def refund_ticket
    # raise SuckerError < StandardError; end
  end

  def fund_event_safe(deposit_wallet:)
    0
  end

  def sold_out?
    @available_tickets.zero?
  end
end
