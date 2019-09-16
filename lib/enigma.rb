require 'date'
require './lib/random_number_generator'
require './lib/encrypter'
require './lib/decrypter'
require './lib/cracker'

class Enigma

  def encrypt(message,
              key = RandomNumberGenerator.get_number,
              date = Date.today.strftime('%d%m%y'))

    encrypter = Encrypter.new(message, key, date)

    { encryption: encrypter.encrypt_message,
      key: key,
      date: date }
  end

  def decrypt(ciphertext, key, date = Date.today.strftime('%d%m%y'))
    decrypter = Decrypter.new(ciphertext, key, date)

    { decryption: decrypter.decrypt_ciphertext,
      key: key,
      date: date }
  end

  def crack(ciphertext, date = Date.today.strftime('%d%m%y'))
    cracker = Cracker.new(ciphertext, date)

    { decryption: cracker.crack_ciphertext,
      key: cracker.crack_key,
      date: date }
  end

end
