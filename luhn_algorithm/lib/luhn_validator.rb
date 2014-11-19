class LuhnValidator
  def validate(digits)
    provided_check_digit(digits) == check_digit_for(digits)
  end

  def expected_check_digit(digits)
    10 - (digits.reduce(:+) % 10)
  end

  def provided_check_digit(digits)
    digits.to_s[-1].to_i
  end

  def mutated_digits(digits)
    digits.to_s.chars[0..-2].reverse.map(&:to_i).each_with_index.map do |digit, index|
      if index.even?
        digit * 2
      else
        digit
      end
    end
  end

  def reduce_double_digits(digits)
    digits.map do |i|
      if i > 9
        i.to_s.chars.map(&:to_i).reduce(:+)
      else
        i
      end
    end
  end

  def check_digit_for(digits)
    expected_check_digit(reduce_double_digits(mutated_digits(digits)))
  end
end
