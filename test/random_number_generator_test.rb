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

  def test_get_number
    assert_equal true, @rand_num_gen.get_number.to_i > 0
    assert_equal true, @rand_num_gen.get_number.to_i <= 99999
    assert_equal true, @rand_num_gen.get_number.length == 5
  end

end
