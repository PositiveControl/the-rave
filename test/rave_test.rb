# frozen_string_literal: true

require "minitest/autorun"
require "pry"
require_relative "../rave"

class RaveTest < Minitest::Test
  def setup
    wallet = OpenStruct.new(balance: 5000)
    @capacity = 555
    @rave = Rave.new(capacity: @capacity, start_time: Time.now.utc, deposit_wallet: wallet)
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

  def test_buy_ticket
    wallet = OpenStruct.new({ balance: 250 })
    tickets_before = @rave.available_tickets
    @rave.buy_ticket(type: :general_admission, quantity: 1, payment_wallet: wallet)

    assert_equal tickets_before, @rave.available_tickets + 1
    assert_equal tickets_before - 1, @rave.available_tickets
  end

  def test_sold_out
    tickets_to_buy = @rave.available_tickets
    beginning_balance = tickets_to_buy * @rave.ticket_cost * 2
    wallet = OpenStruct.new({ balance: beginning_balance })

    refute @rave.sold_out?
    assert @rave.buy_ticket(quantity: tickets_to_buy, payment_wallet: wallet)
    assert @rave.sold_out?
    refute @rave.buy_ticket(payment_wallet: wallet)
    assert beginning_balance > wallet.balance
    assert @rave.event_safe == beginning_balance - wallet.balance
  end
end
