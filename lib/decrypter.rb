require './lib/shiftable'

class Decrypter
  include Shiftable

  attr_reader :message, :key, :date

  def initialize(message, key, date)
    @message = message
    @key = key
    @date = date
    @alphabet = ('a'..'z').to_a << ' '
  end

  def unshift_message
    shifts = get_shifts.map { |shift| 27 - shift }
    decrypted_message = @message.downcase.split('')

    decrypted_message.each_with_index do |char, index|
      if @alphabet.include?(char)
        alpha_index = @alphabet.index(char)
        shifted_alpha = @alphabet.rotate(shifts[index % 4])
        decrypted_message[index] = shifted_alpha[alpha_index]
      end
    end

    decrypted_message.join('')
  end


end
