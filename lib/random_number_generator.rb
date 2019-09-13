class RandomNumberGenerator

  def get_number
    rand(100000).to_s.rjust(5, '0')
  end

end
