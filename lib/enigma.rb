require 'date'
require './lib/random_number_generator'
require './lib/encrypter'

class Enigma

  def encrypt(message,
              key = RandomNumberGenerator.get_number,
              date = Date.today.strftime('%d%m%y'))

    encrypter = Encrypter.new(message, key, date)

    { encryption: encrypter.shift_message,
      key: key,
      date: date }
  end

end
