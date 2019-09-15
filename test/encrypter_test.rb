require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/encrypter'

class EncrypterTest < Minitest::Test

  def setup
    @encrypter = Encrypter.new('HEllO woRLd eNd', '08304', '291018')
  end

  def test_it_exists
    assert_instance_of Encrypter, @encrypter
  end

  def test_initialize
    assert_equal 'HEllO woRLd eNd', @encrypter.message
    assert_equal '08304', @encrypter.key
    assert_equal '291018', @encrypter.date
  end

  def test_shift_message
    assert_equal 'vjqtbeaweqihssi', @encrypter.shift_message
  end

end
