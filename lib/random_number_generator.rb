class RandomNumberGenerator

  def self.get_number(num_digits = 5)
    rand(10 ** num_digits)
      .to_s
      .rjust(num_digits, '0')
  end

end
