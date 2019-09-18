module Shiftable

  def get_keys(key = @key)
    [ key[0..1].to_i,
      key[1..2].to_i,
      key[2..3].to_i,
      key[3..4].to_i ]
  end

  def get_offsets(date = @date)
    digits = (date.to_i ** 2).to_s
    [ digits[-4].to_i,
      digits[-3].to_i,
      digits[-2].to_i,
      digits[-1].to_i ]
  end

  def get_shifts(keys = get_keys, date = @date)
    keys
      .zip(get_offsets(date))
      .map { |shifts| (shifts[0] + shifts[1]) % 27 }
  end

  def shift_text(text, shifts)
    message_chars = text.downcase.split('')
    shifted_alphas = shifts.map { |shift| @alphabet.rotate(shift) }
    shift(message_chars, shifted_alphas)
  end


  #-------------Helper Methods-------------#

  def shift(message_chars, shifted_alphas)
    message_chars.each_with_index do |char, index|
      if shifted_alphas[0].include?(char)
        alpha_index = @alphabet.index(char)
        message_chars[index] = shifted_alphas[index % 4][alpha_index]
      end
    end
    message_chars.join('')
  end

end
