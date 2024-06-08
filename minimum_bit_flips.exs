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

  def min_bit_flips_ii(start, goal) do
    while_not_zero(0, Bitwise.bxor(start, goal))
  end
  defp while_not_zero(out, tmp) when tmp > 0 do
    while_not_zero(out + Bitwise.band(tmp, 1), Bitwise.bsr(tmp, 1))
  end
  # Important! Call the Return after Calling "when tmp > 0"
  defp while_not_zero(out, _), do: out
end

IO.inspect(Solution.min_bit_flips(10, 7))
# Output: 3
IO.inspect(Solution.min_bit_flips(3, 4))
# Output: 3
IO.inspect(Solution.min_bit_flips(10**9, 1))
# Output: 14

IO.inspect(Solution.min_bit_flips_ii(10, 7))
# Output: 3
IO.inspect(Solution.min_bit_flips_ii(3, 4))
# Output: 3
IO.inspect(Solution.min_bit_flips_ii(10**9, 1))
# Output: 14
