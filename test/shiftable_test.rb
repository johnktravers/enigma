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
    assert_equal [26, 61, 14, 49], @encrypter.get_keys('26149')
  end

  def test_get_offsets
    assert_equal [6, 3, 2, 4], @encrypter.get_offsets
    assert_equal [6, 4, 0, 9], @encrypter.get_offsets('090597')
  end

  def test_get_shifts
    assert_equal [14, 5, 5, 8], @encrypter.get_shifts
    assert_equal [5, 10, 16, 26], @encrypter.get_shifts([26, 61, 14, 49])

    expected = [5, 11, 14, 4]
    assert_equal expected, @encrypter.get_shifts([26, 61, 14, 49], '090597')
  end

  def test_shift_text
    actual = @encrypter.shift_text('HEllO woRLd eNd', [14, 86, 32, 8])
    assert_equal 'vjqtbeaweqihssi', actual
  end


  #-------------Tests for Helper Methods-------------#

  def test_shift
    message_chars = 'hi there. how are you? end'.split('')
    alphabet = ('a'..'z').to_a << ' '
    shifts = [5, 10, 16, 26]
    shifted_alphas = shifts.map { |shift| alphabet.rotate(shift) }

    actual = @encrypter.shift(message_chars, alphabet, shifted_alphas)
    assert_equal "mspsmogd.jxnajqqjjnnz?pdsn", actual
  end

end
