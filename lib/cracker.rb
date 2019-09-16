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
    shift_text(ciphertext, shifts)
  end

  def crack_key
    keys = get_crack_keys(ciphertext, date)
    create_crack_key(keys)
  end

end
