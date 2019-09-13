require './lib/shiftable'

class Encrypter
  include Shiftable

  attr_reader :message, :key, :date

  def initialize(message, key = "12345", date = "130919")
    @message = message
    @key = key
    @date = date
  end

end
