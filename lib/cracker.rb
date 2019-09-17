require './lib/shiftable'

class Cracker
  include Shiftable

  attr_reader :ciphertext, :date

  def initialize(ciphertext, date)
    @ciphertext = ciphertext
    @date = date
  end

  def crack_ciphertext
    shifts = get_crack_shifts(ciphertext)
    shift_text(ciphertext, shifts)
  end

  def crack_key
    keys = get_crack_keys(ciphertext, date)
    create_crack_key(keys)
  end


  #------------Helper Methods------------#

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
    aligned_keys = possible_keys(keys)
    aligned_keys = delete_row_1_by_row_2(aligned_keys)
    aligned_keys = delete_row_1_by_row_0(aligned_keys)
    aligned_keys = delete_row_2_by_row_1(aligned_keys)
    aligned_keys = delete_row_2_by_row_3(aligned_keys)
    aligned_keys = delete_row_0_by_row_1(aligned_keys)
    delete_row_3_by_row_2(aligned_keys).flatten
  end

  def create_crack_key(keys)
    aligned = align_keys(keys)
    if aligned.length == 4
      aligned[0] + aligned[1][1] + aligned[2][1] + aligned[3][1]
    elsif aligned.length > 4
      keys = [aligned[0]]
      keys[1] = aligned.find { |num| keys[0][1] == num[0] }
      keys[2] = aligned.find { |num| keys[1][1] == num[0] }
      keys[3] = aligned.find { |num| keys[2][1] == num[0] }
      keys[0] + keys[1][1] + keys[2][1] + keys[3][1]
    else
      '(No key found)'
    end
  end


  #------------Helper Helper Methods------------#

  def delete_row_1_by_row_2(aligned_keys)
    aligned_keys[1].delete_if do |key1|
      aligned_keys[2].none? { |key2| key1[1] == key2[0] }
    end
    aligned_keys
  end

  def delete_row_2_by_row_1(aligned_keys)
    aligned_keys[2].delete_if do |key2|
      aligned_keys[1].none? { |key1| key1[1] == key2[0] }
    end
    aligned_keys
  end

  def delete_row_0_by_row_1(aligned_keys)
    aligned_keys[0].delete_if do |key0|
      aligned_keys[1].none? { |key1| key0[1] == key1[0] }
    end
    aligned_keys
  end

  def delete_row_1_by_row_0(aligned_keys)
    aligned_keys[1].delete_if do |key1|
      aligned_keys[0].none? { |key0| key0[1] == key1[0] }
    end
    aligned_keys
  end

  def delete_row_3_by_row_2(aligned_keys)
    aligned_keys[3].delete_if do |key3|
      aligned_keys[2].none? { |key2| key2[1] == key3[0] }
    end
    aligned_keys
  end

  def delete_row_2_by_row_3(aligned_keys)
    aligned_keys[2].delete_if do |key2|
      aligned_keys[3].none? { |key3| key2[1] == key3[0] }
    end
    aligned_keys
  end

end
