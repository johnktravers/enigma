require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/cracker'

class CrackerTest < Minitest::Test

  def setup
    @cracker = Cracker.new('vjqtbeaweqihssi', '291018')
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

end
