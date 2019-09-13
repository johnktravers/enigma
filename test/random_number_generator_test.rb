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

  def test_get_number
    number = RandomNumberGenerator.get_number

    assert_equal true, number.to_i > 0 && number.to_i <= 99999
    assert_equal true, number.length == 5
  end

end
