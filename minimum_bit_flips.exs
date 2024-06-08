# https://leetcode.com/problems/minimum-bit-flips-to-convert-number/description/
# 2220. Minimum Bit Flips to Convert Number

defmodule Solution do
  @spec min_bit_flips(start :: integer, goal :: integer) :: integer
  def min_bit_flips(start, goal) do
    # IO.inspect(Integer.digits(start, 2))
    # IO.inspect(Integer.digits(goal, 2))
    # find the bitwise differences
    Bitwise.bxor(start, goal)
    |> Integer.digits(2)
    # and count them
    |> Enum.sum()
  end
end

IO.inspect(Solution.min_bit_flips(10, 7))
# Output: 3
IO.inspect(Solution.min_bit_flips(3, 4))
# Output: 3
IO.inspect(Solution.min_bit_flips(10**9, 1))
# Output: 14
