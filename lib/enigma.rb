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

  def decrypt(message, key, date = Date.today.strftime('%d%m%y'))
    decrypter = Decrypter.new(message, key, date)

    { decryption: decrypter.decrypt_message,
      key: key,
      date: date }
  end

  def crack(ciphertext, date = Date.today.strftime('%d%m%y'))
    cracker = Cracker.new(ciphertext, date)
    shifts = cracker.get_crack_shifts(ciphertext)
    keys = cracker.get_crack_keys(ciphertext, date)

    { decryption: cracker.shift_message(ciphertext, shifts),
      key: cracker.create_crack_key(keys),
      date: date }
  end

end
