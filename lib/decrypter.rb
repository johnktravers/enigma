require './lib/shiftable'

class Decrypter
  include Shiftable

  attr_reader :ciphertext, :key, :date

  def initialize(ciphertext, key, date)
    @ciphertext = ciphertext
    @key = key
    @date = date
    @alphabet = ('a'..'z').to_a << ' '
  end

  def decrypt_ciphertext
    shifts = get_shifts.map { |shift| 27 - shift }
    shift_text(@ciphertext, shifts)
  end

end
