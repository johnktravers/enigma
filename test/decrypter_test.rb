require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require './lib/decrypter'

class DecrypterTest < Minitest::Test

  def setup
    @decrypter = Decrypter.new('keder ohulw', '02715', '040895')
  end

  def test_it_exists
    assert_instance_of Decrypter, @decrypter
  end

  def test_initialize
    assert_equal 'keder ohulw', @decrypter.message
    assert_equal '02715', @decrypter.key
    assert_equal '040895', @decrypter.date
  end

  def test_decrypt_message
    assert_equal 'hello world', @decrypter.decrypt_message
  end

end
