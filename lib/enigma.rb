require './lib/encrypter'

class Enigma

  def encrypt(message, key, date)
    encrypter = Encrypter.new(message, key, date)

    {
      encryption: encrypter.shift_message,
      key: key,
      date: date
    }
  end

end
