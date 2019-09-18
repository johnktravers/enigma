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

  def key_combinations(keys)
    possible_keys = possible_keys(keys)
    possible_keys[0].product(possible_keys[1], possible_keys[2], possible_keys[3])
  end

  def filter_key_combos(keys)
    combos = key_combinations(keys)
    combos.find_all do |combo|
      combo[0][1] == combo[1][0] && combo[1][1] == combo[2][0] && combo[2][1] == combo[3][0]
    end
  end

  def create_crack_key(keys)
    filtered = filter_key_combos(keys)

    if filtered.length == 1
      filtered.flatten!
      return filtered[0] + filtered[1][1] + filtered[2][1] + filtered[3][1]
    elsif filtered.length > 1
      filtered.each do |key_arr|
        keys_attempt = key_arr.map { |key| key.to_i }
        if shift_text(@ciphertext, get_shifts(keys_attempt, @date))
          return key_arr[0] + key_arr[1][1] + key_arr[2][1] + key_arr[3][1]
        end
      end
    else
      '(No key found)'
    end

  end

end
