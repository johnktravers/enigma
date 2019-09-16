require 'date'
require './lib/random_number_generator'
require './lib/encrypter'
require './lib/decrypter'

class Enigma

  def encrypt(message,
              key = RandomNumberGenerator.get_number,
              date = Date.today.strftime('%d%m%y'))

    encrypter = Encrypter.new(message, key, date)

    { encryption: encrypter.encrypt_message,
      key: key,
      date: date }
  end

  def decrypt(message, key, date = Date.today.strftime('%d%m%y'))
    decrypter = Decrypter.new(message, key, date)

    { decryption: decrypter.decrypt_message,
      key: key,
      date: date }
  end

  def crack(ciphertext, date = Date.today.strftime('%d%m%y'))
    decrypter = Decrypter.new(ciphertext.reverse, '00000', date)

    shifts = decrypter.get_crack_shifts(ciphertext)
    decrypter.shift_message(shifts).reverse

    { decryption: decrypter.shift_message(shifts).reverse,
      key: '00000',
      date: date }
  end

end
