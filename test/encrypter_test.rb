require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/random_number_generator'
require './lib/encrypter'

class EncrypterTest < Minitest::Test

  def setup
    @encrypter_1 = Encrypter.new('HEllO woRLd eNd', '08304', '291018')
    @encrypter_2 = Encrypter.new('Hello, world!')
  end

  def test_it_exists
    assert_instance_of Encrypter, @encrypter_1
    assert_instance_of Encrypter, @encrypter_2
  end

  def test_initialize
    assert_equal 'HEllO woRLd eNd', @encrypter_1.message
    assert_equal '08304', @encrypter_1.key
    assert_equal '291018', @encrypter_1.date

    assert_equal 'Hello, world!', @encrypter_2.message
    assert_equal '12345', @encrypter_2.key
    assert_equal '130919', @encrypter_2.date
  end

  def test_shift_message
    # assert_equal 'vjqtbeaweqihssi', @encrypter_1.shift_message
    assert_equal 'xfydd,modsyw!', @encrypter_2.shift_message
  end

end
