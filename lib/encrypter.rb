require './lib/shiftable'

class Encrypter
  include Shiftable

  attr_reader :message, :key, :date

  def initialize(message, key, date)
    @message = message
    @key = key
    @date = date
    @alphabet = ('a'..'z').to_a << ' '
  end

  def shift_message
    shifts = get_shifts
    encrypted_message = @message.downcase.split('')

    encrypted_message.each_with_index do |char, index|
      if @alphabet.include?(char)
        alpha_index = @alphabet.index(char)
        shifted_alpha = @alphabet.rotate(shifts[index % 4])
        encrypted_message[index] = shifted_alpha[alpha_index]
      end
    end

    encrypted_message.join('')
  end

end
