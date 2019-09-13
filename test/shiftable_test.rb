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
    expected = { a: 56, b: 63, c: 30, d: 9 }
    assert_equal expected, @encrypter.get_keys
  end

  def test_get_offsets
    expected = { a: 7, b: 8, c: 5, d: 6 }
    assert_equal expected, @encrypter.get_offsets
  end

  def test_get_shifts
    expected = { a: 63, b: 71, c: 35, d: 15 }
    assert_equal expected, @encrypter.get_shifts
  end

end
