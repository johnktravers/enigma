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

  def get_shifts
    get_keys
      .zip(get_offsets)
      .map { |shifts| shifts[0] + shifts[1] }
  end

  def get_crack_shifts(ciphertext)
    alphabet = ('a'..'z').to_a << ' '
    split = ciphertext.split('')
    shifts = []
    shifts[0] = alphabet.index(' ') - alphabet.index(split[-4])
    shifts[1] = alphabet.index('e') - alphabet.index(split[-3])
    shifts[2] = alphabet.index('n') - alphabet.index(split[-2])
    shifts[3] = alphabet.index('d') - alphabet.index(split[-1])
    shifts.rotate!(4 - (split.length % 4))
  end

  def get_crack_keys(ciphertext, date)
    keys = []
    shifts = get_crack_shifts(ciphertext)
    offsets = get_offsets(date)
    shifts.each_with_index do |shift, index|
      keys.push( -1 * shift - offsets[index])
    end
    keys
  end

  def shift_message(shifts)
    alphabet = ('a'..'z').to_a << ' '
    shifted_message = @message.downcase.split('')

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
