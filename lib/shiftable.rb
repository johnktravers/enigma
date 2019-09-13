module Shiftable

  def get_keys
    {
      a: @key[0..1].to_i,
      b: @key[1..2].to_i,
      c: @key[2..3].to_i,
      d: @key[3..4].to_i
    }
  end

  def get_offsets
    digits = (@date.to_i ** 2).to_s

    {
      a: digits[-4].to_i,
      b: digits[-3].to_i,
      c: digits[-2].to_i,
      d: digits[-1].to_i
    }
  end

end
