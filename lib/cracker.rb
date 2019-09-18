require './lib/shiftable'

class Cracker
  include Shiftable

  attr_reader :ciphertext, :date

  def initialize(ciphertext, date)
    @ciphertext = ciphertext
    @date = date
    @alphabet = ('a'..'z').to_a << ' '
  end

  def crack_ciphertext
    shifts = get_crack_shifts(@ciphertext)
    shift_text(@ciphertext, shifts)
  end

  def crack_key
    keys = get_crack_keys(@ciphertext, date)
    create_crack_key(keys)
  end


  #------------Helper Methods------------#

  def get_crack_shifts(ciphertext)
    split = ciphertext.split('')
    shifts = []
    shifts[0] = (@alphabet.index(' ') - @alphabet.index(split[-4])) % 27
    shifts[1] = (@alphabet.index('e') - @alphabet.index(split[-3])) % 27
    shifts[2] = (@alphabet.index('n') - @alphabet.index(split[-2])) % 27
    shifts[3] = (@alphabet.index('d') - @alphabet.index(split[-1])) % 27
    shifts.rotate!(4 - (split.length % 4))
  end

  def get_crack_keys(ciphertext, date)
    keys = []
    shifts = get_crack_shifts(ciphertext)
    offsets = get_offsets(date)
    shifts.each_with_index do |shift, index|
      keys.push((-1 * shift - offsets[index]) % 27)
    end
    keys
  end

  def create_crack_key(keys)
    filtered = filter_key_combos(keys)
    if filtered.length >= 1
      keys = filtered[0]
      keys[0] + keys[1][1] + keys[2][1] + keys[3][1]
    else
      '(No key found)'
    end
  end


  #------------Helper Helper Methods------------#

  def filter_key_combos(keys)
    combos = key_combinations(keys)
    combos.find_all do |combo|
      combo[0][1] == combo[1][0] &&
      combo[1][1] == combo[2][0] &&
      combo[2][1] == combo[3][0]
    end
  end

  def key_combinations(keys)
    maybe_keys = possible_keys(keys)
    maybe_keys[0].product(maybe_keys[1], maybe_keys[2], maybe_keys[3])
  end

  def possible_keys(keys)
    possible = Array.new(4) { Array.new }
    keys.each_with_index do |key, index|
      until key >= 100
        possible[index].push(key.to_s.rjust(2, '0'))
        key += 27
      end
    end
    possible
  end

end
