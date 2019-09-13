module Shiftable

  def get_keys
    [ @key[0..1].to_i,
      @key[1..2].to_i,
      @key[2..3].to_i,
      @key[3..4].to_i ]
  end

  def get_offsets
    digits = (@date.to_i ** 2).to_s

    [ digits[-4].to_i,
      digits[-3].to_i,
      digits[-2].to_i,
      digits[-1].to_i ]
  end

  def get_shifts
    offsets = get_offsets
    shifts = []

    get_keys.each_with_index do |key, index|
      shifts.push(key + offsets[index])
    end

    shifts
  end

end
