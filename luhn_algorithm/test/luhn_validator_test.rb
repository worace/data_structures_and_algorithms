gem 'minitest'
require 'minitest/autorun'
require_relative '../lib/luhn_validator'

class LuhnTest < Minitest::Test
  # This test suite is not meant to be exhaustive,
  # just a start. Write your own tests!

  attr_reader :validator

  def setup
    @validator = LuhnValidator.new
  end

  def test_it_validates_the_example_account_number
    assert validator.validate('79927398713')
  end

  def test_it_gets_provided_check_digit
    assert_equal 3, validator.provided_check_digit('79927398713')
  end

  def test_it_produces_list_of_doubled_digits
    start = '79927398713'
    doubled = %w(7 18 9 4 7 6 9 16 7 2).map(&:to_i).reverse
    assert_equal doubled, validator.mutated_digits(start)
  end

  def test_it_reduces_2_digit_numbers_in_the_sum_array
    start = %w(7 18 9 4 7 6 9 16 7 2).map(&:to_i)
    assert_equal %w(7 9 9 4 7 6 9 7 7 2).map(&:to_i), validator.reduce_double_digits(start)
  end

  def test_it_finds_the_check_digit_for_an_identifier
    assert_equal 3, validator.check_digit_for('7992739871')
  end

  def test_expected_check_digit_should_give_the_sum_of_digits_mod_10
    assert_equal 3, validator.expected_check_digit(%w(7 9 9 4 7 6 9 7 7 2).map(&:to_i))
  end

  def test_more_cases
    valid = [4093585357742956, 4501620393760906, 4763270654394525, 5540220157638214]
    invalid = [79927398710, 79927398711, 79927398712, 79927398713, 79927398714, 79927398715, 79927398716, 79927398717, 79927398718, 79927398719]

    valid.each do |number|
      assert @validator.validate(number), "#{number} should be valid"
    end
    invalid.each do |number|
      assert !@validator.validate(number), "#{number} should not be valid"
    end
  end
end