require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/cracker'

class CrackerTest < Minitest::Test

  def setup
    @cracker = Cracker.new('vjqtbeaweqihssi', '291018')
    @cracked_keys = [-5, -12, 8, -4]
  end

  def test_it_exists
    assert_instance_of Cracker, @cracker
  end

  def test_initialize
    assert_equal 'vjqtbeaweqihssi', @cracker.ciphertext
    assert_equal '291018', @cracker.date
  end

  def test_crack_ciphertext
    assert_equal 'hello world end', @cracker.crack_ciphertext
  end

  def test_crack_key

  end



  #------------Tests for Helper Methods------------#

  def test_get_crack_shifts
    expected = [-14, -5, -5, 19]
    assert_equal expected, @cracker.get_crack_shifts('vjqtbeaweqihssi')
  end

  def test_get_crack_keys
    expected = [8, 2, 3, -23]
    actual = @cracker.get_crack_keys('vjqtbeaweqihssi', '291018')
    assert_equal expected, actual
  end

  def test_possible_keys
    expected = [
      ['22', '49', '76'],
      ['15', '42', '69', '96'],
      ['08', '35', '62', '89'],
      ['23', '50', '77']
    ]
    assert_equal expected, @cracker.possible_keys(@cracked_keys)
  end

  def test_align_keys
    expected = ['49', '96', '62', '23']
    assert_equal expected, @cracker.align_keys(@cracked_keys)
  end

  def test_create_crack_key
    assert_equal '49623', @cracker.create_crack_key(@cracked_keys)
  end

end
