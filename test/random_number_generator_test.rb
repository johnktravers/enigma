require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/random_number_generator'

class RandomNumberGeneratorTest < Minitest::Test

  def setup
    @rand_num_gen = RandomNumberGenerator.new
  end

  def test_it_exists
    assert_instance_of RandomNumberGenerator, @rand_num_gen
  end

  def test_initialize
    expected = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
    assert_equal expected, @rand_num_gen.all_numbers
  end

end
