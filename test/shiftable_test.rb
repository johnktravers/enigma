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
    expected = [-14, -5, -5, 19]
    assert_equal expected, @encrypter.get_crack_shifts('vjqtbeaweqihssi')
  end

  def test_get_crack_keys
    expected = [8, 2, 3, -23]
    assert_equal expected, @encrypter.get_crack_keys('vjqtbeaweqihssi', '291018')
  end

  def test_possible_keys
    expected = [
      ['22', '49', '76'],
      ['15', '42', '69', '96'],
      ['08', '35', '62', '89'],
      ['23', '50', '77']
    ]
    assert_equal expected, @encrypter.possible_keys([-5, -12, 8, -4])
  end

  def test_align_keys
    assert_equal ['49', '96', '62', '23'], @encrypter.align_keys([-5, -12, 8, -4])
  end

  def test_shift_message
    assert_equal 'vjqtbeaweqihssi', @encrypter.shift_message([14, 86, 32, 8])
  end

end
