require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/encrypter'

class EncrypterTest < Minitest::Test

  def setup
    @encrypter = Encrypter.new('HEllO woRLd eNd', '08304', '291018')
  end

  def test_it_exists
    assert_instance_of Encrypter, @encrypter
  end

  def test_initialize_with_three_parameters
    assert_equal 'HEllO woRLd eNd', @encrypter.message
    assert_equal '08304', @encrypter.key
    assert_equal '291018', @encrypter.date
  end

  def test_initialize_with_one_parameter
    RandomNumberGenerator.expects(:get_number).returns('12345')
    encrypter_2 = Encrypter.new('Hello, world!')

    assert_equal 'Hello, world!', encrypter_2.message
    assert_equal '12345', encrypter_2.key
    assert_equal Date.today.strftime('%d%m%y'), encrypter_2.date
  end

  def test_shift_message
    RandomNumberGenerator.expects(:get_number).returns('12345')
    encrypter_2 = Encrypter.new('Hello, world!')

    assert_equal 'vjqtbeaweqihssi', @encrypter.shift_message
    assert_equal 'xfydd,modsyw!', encrypter_2.shift_message
  end

end
