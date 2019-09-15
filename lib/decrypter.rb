require './lib/shiftable'

class Decrypter
  include Shiftable

  attr_reader :message, :key, :date

  def initialize(message, key, date)
    @message = message
    @key = key
    @date = date
  end

  def decrypt_message
    shifts = get_shifts.map { |shift| 27 - shift }
    shift_message(shifts)
  end

end
