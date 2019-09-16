require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/random_number_generator'

class RandomNumberGeneratorTest < Minitest::Test

  def test_it_exists
    rand_num_gen = RandomNumberGenerator.new

    assert_instance_of RandomNumberGenerator, rand_num_gen
  end

  def test_get_number_with_default_number_of_digits
    number = RandomNumberGenerator.get_number

    assert_equal true, number.to_i >= 0 && number.to_i < 100_000
    assert_equal true, number.length == 5
  end

  def test_get_number_with_given_number_of_digits
    number = RandomNumberGenerator.get_number(1)
    assert_equal true, number.to_i >= 0 && number.to_i < 10
    assert_equal true, number.length == 1

    number = RandomNumberGenerator.get_number(9)
    assert_equal true, number.to_i >= 0 && number.to_i < 1_000_000_000
    assert_equal true, number.length == 9
  end

end
