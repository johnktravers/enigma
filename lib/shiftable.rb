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

  def possible_keys(keys)
    possible = []
    keys.each_with_index do |key, index|
      possible[index] = []
      num = key % 27
      until num >= 100
        possible[index].push(num.to_s.rjust(2, '0'))
        num += 27
      end
    end
    possible
  end

  def align_keys(keys)
    possible = possible_keys(keys)
    aligned = []

    possible[1].each do |key1|
      aligned[2] = possible[2].find_all { |key2| key1[1] == key2[0] }
    end

    possible[1].each do |key1|
      aligned[0] = possible[0].find_all { |key0| key0[1] == key1[0] }
    end

    aligned[0].each do |key0|
      aligned[1] = possible[1].find_all { |key1| key0[1] == key1[0] }
    end

    aligned[2].each do |key2|
      aligned[3] = possible[3].find_all { |key3| key2[1] == key3[0] }
    end

    aligned.flatten
  end

  def create_crack_key(keys)
    aligned = align_keys(keys)
    aligned[0] + aligned[1][1] + aligned[2][1] + aligned[3][1]
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
