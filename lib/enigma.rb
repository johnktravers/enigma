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
    key = '99999'

    100000.times do
      attempt = decrypt(ciphertext, key, date)
      return attempt if attempt[:decryption][-4..-1] == ' end'
      key = (key.to_i - 1).to_s.rjust(5, '0')
    end
    "The ciphertext was uncrackable."
  end

end
