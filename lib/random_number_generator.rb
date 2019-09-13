class RandomNumberGenerator

  # Generate number for any number of digits
  def self.get_number
    rand(100000).to_s.rjust(5, '0')
  end

end
