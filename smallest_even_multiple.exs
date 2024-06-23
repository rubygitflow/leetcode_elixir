# https://leetcode.com/problems/smallest-even-multiple/description/
# 2413. Smallest Even Multiple

import Integer

defmodule Solution do
  @spec smallest_even_multiple(n :: integer) :: integer
  def smallest_even_multiple(n) when is_even(n), do: n
  def smallest_even_multiple(n), do: n * 2

  # def smallest_even_multiple(n), do: if(rem(n, 2) == 0, do: n, else: n * 2)
end

IO.inspect(Solution.smallest_even_multiple(5))
# Output: 10
IO.inspect(Solution.smallest_even_multiple(6))
# Output: 6
