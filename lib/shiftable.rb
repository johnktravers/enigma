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
      .map { |shifts| shifts[0] + shifts[1] }
  end

  def shift_text(text, shifts)
    alphabet = ('a'..'z').to_a << ' '
    shifted_message = text.downcase.split('')

    shifted_message.each_with_index do |char, index|
      if alphabet.include?(char)
        alpha_index = alphabet.index(char)
        shifted_alpha = alphabet.rotate(shifts[index % 4])
        shifted_message[index] = shifted_alpha[alpha_index]
      end
    end

    shifted_message.join('')
  end

end
