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


  #-----------Encrypt Tests-----------#

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


  #-----------Decrypt Tests-----------#

  def test_decrypt_with_message_key_and_date
    expected = {
      decryption: 'hello world',
      key: '02715',
      date: '040895'
    }
    assert_equal expected, @enigma.decrypt('keder ohulw', '02715', '040895')
  end

  def test_decrypt_with_message_and_key
    Date.expects(:today).returns(Date.new(1985, 11, 16))

    expected = {
      decryption: 'why hello there.',
      key: '02715',
      date: '161185'
    }
    assert_equal expected, @enigma.decrypt('bjqtngdeublaktx.', '02715')
  end


  #-----------Crack Tests-----------#

  def test_crack_with_message_and_date
    expected = {
      decryption: 'hello world end',
      key: '08304',
      date: '291018'
    }
    assert_equal expected, @enigma.crack('vjqtbeaweqihssi', '291018')
  end

  def test_crack_with_message_only
    Date.expects(:today).returns(Date.new(1985, 11, 16))

    expected = {
      decryption: 'what a lovely day end',
      key: '49623',
      date: '161185'
    }
    assert_equal expected, @enigma.crack('vykuzrjmnlomxqnbxqooc')
  end

  def test_crack_with_message_only_and_todays_date
    Date.expects(:today).returns(Date.new(2019, 9, 16))

    expected = {
      decryption: 'what a lovely day end',
      key: 'No key found',
      date: '160919'
    }
    assert_equal expected, @enigma.crack('vykuzrjmnlomxqnbxqooc')
  end

end
