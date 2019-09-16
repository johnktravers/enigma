require './lib/shiftable'

class Cracker
  include Shiftable

  attr_reader :ciphertext, :date

  def initialize(ciphertext, date)
    @ciphertext = ciphertext
    @date = date
  end

  def crack_ciphertext
    shifts = get_crack_shifts(ciphertext)
    shift_message(ciphertext, shifts)
  end

end
