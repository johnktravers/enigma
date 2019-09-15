require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/enigma'

class EnigmaTest < Minitest::Test

  def setup
    @enigma = Enigma.new
  end

  def test_it_exists
    assert_instance_of Enigma, @enigma
  end

  def test_encrypt_with_message_key_and_date
    expected = {
      encryption: 'keder ohulw',
      key: '02715',
      date: '040895'
    }
    assert_equal expected, @enigma.encrypt('hello world', '02715', '040895')
  end

  def test_encrypt_with_message_and_key
    Date.expects(:today).returns(Date.new(1985, 11, 16))

    expected = {
      encryption: 'bjqtngdeublaktx.',
      key: '02715',
      date: '161185'
    }
    assert_equal expected, @enigma.encrypt('Why hello there.', '02715')
  end

  def test_encrypt_with_message_only
    RandomNumberGenerator.expects(:get_number).returns('12345')
    Date.expects(:today).returns(Date.new(2019, 6, 17))

    expected = {
      encryption: 'wbydcxgfxsrjgb!',
      key: '12345',
      date: '170619'
    }
    assert_equal expected, @enigma.encrypt('Hello Universe!')
  end

end
