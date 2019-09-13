require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/encrypter'

class ShiftableTest < Minitest::Test

  def setup
    @encrypter = Encrypter.new("Hello, world!", "56309", "250684")
  end

  def test_get_keys
    expected = [56, 63, 30, 9]
    assert_equal expected, @encrypter.get_keys
  end

  def test_get_offsets
    expected = [7, 8, 5, 6]
    assert_equal expected, @encrypter.get_offsets
  end

  def test_get_shifts
    expected = [63, 71, 35, 15]
    assert_equal expected, @encrypter.get_shifts
  end

end
