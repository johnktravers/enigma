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

  def encrypt_message
    shift_text(@message, get_shifts)
  end

end
