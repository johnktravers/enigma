require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/cracker'

class CrackerTest < Minitest::Test

  def setup
    @cracker = Cracker.new('vykuzrjmnlomxqnbxqooc', '161185')
  end

  def test_it_exists
    assert_instance_of Cracker, @cracker
  end

  def test_initialize
    assert_equal 'vykuzrjmnlomxqnbxqooc', @cracker.ciphertext
    assert_equal '161185', @cracker.date
  end

  def test_crack_ciphertext
    assert_equal 'what a lovely day end', @cracker.crack_ciphertext
  end

  def test_crack_key
    assert_equal '49623', @cracker.crack_key
  end


  #------------Tests for Helper Methods------------#

  def test_get_crack_shifts
    expected = [13, 22, 22, 19]
    assert_equal expected, @cracker.get_crack_shifts('vjqtbeaweqihssi')
  end

  def test_get_crack_keys
    expected = [8, 2, 3, 4]
    actual = @cracker.get_crack_keys('vjqtbeaweqihssi', '291018')
    assert_equal expected, actual
  end

  def test_create_crack_key
    assert_equal '49623', @cracker.create_crack_key([22, 15, 8, 23])
    assert_equal '48136', @cracker.create_crack_key([21, 0, 13, 9])
  end


  #------------Tests for Helper Helper Methods------------#

  def test_filter_key_combos
    expected = [['49', '96', '62', '23']]
    assert_equal expected, @cracker.filter_key_combos([22, 15, 8, 23])

    expected = [['48', '81', '13', '36'], ['75', '54', '40', '09']]
    assert_equal expected, @cracker.filter_key_combos([21, 0, 13, 9])
  end

  def test_key_combinations
    assert_equal 192, @cracker.key_combinations([21, 0, 13, 9]).length

    expected = ['21', '00', '13', '09']
    assert_equal expected, @cracker.key_combinations([21, 0, 13, 9])[0]

    expected = ['75', '81', '94', '90']
    assert_equal expected, @cracker.key_combinations([21, 0, 13, 9])[191]
  end

  def test_possible_keys
    expected = [
      ['21', '48', '75'],
      ['00', '27', '54', '81'],
      ['13', '40', '67', '94'],
      ['09', '36', '63', '90']
    ]
    assert_equal expected, @cracker.possible_keys([21, 0, 13, 9])
  end

  def test_add_possible_keys
    expected = [[], ['13', '40', '67', '94']]
    assert_equal expected, @cracker.add_possible_keys([[], []], 13, 1)
  end

end
