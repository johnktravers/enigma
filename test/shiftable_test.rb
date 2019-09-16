require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/encrypter'

class ShiftableTest < Minitest::Test

  def setup
    @encrypter = Encrypter.new('HEllO woRLd eNd', '08304', '291018')
  end

  def test_get_keys
    assert_equal [8, 83, 30, 4], @encrypter.get_keys
  end

  def test_get_offsets
    assert_equal [6, 3, 2, 4], @encrypter.get_offsets
  end

  def test_get_shifts
    assert_equal [14, 86, 32, 8], @encrypter.get_shifts
  end

  def test_get_crack_shifts
    expected = [-5, -5, -14, 19]
    assert_equal expected, @encrypter.get_crack_shifts('vjqtbeaweqihssi')
  end

  def test_shift_message
    assert_equal 'vjqtbeaweqihssi', @encrypter.shift_message([14, 86, 32, 8])
  end

end
