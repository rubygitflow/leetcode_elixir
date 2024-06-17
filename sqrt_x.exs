# https://leetcode.com/problems/sqrtx/description/
# 69. Sqrt(x)

defmodule Solution do
  @spec my_sqrt(x :: integer) :: integer
  def my_sqrt(x) do
    do_my_sqrt(0, x, x)
  end

  defp do_my_sqrt(l, r, target) when l < r do
    middle = div(l + r + 1, 2)
    case middle * middle do
      square when square < target ->  do_my_sqrt(middle, r, target)
      square when square > target -> do_my_sqrt(l, middle - 1, target)
      _ -> middle
    end
  end
  defp do_my_sqrt(l, _, _), do: l 
end


IO.inspect(Solution.my_sqrt(4))
# Output: 2
IO.inspect(Solution.my_sqrt(8))
# Output: 2
IO.inspect(Solution.my_sqrt(1))
# Output: 1
IO.inspect(Solution.my_sqrt(0))
# Output: 0
IO.inspect(Solution.my_sqrt(2**31 - 1))
# Output: 46340
IO.inspect(Solution.my_sqrt(2147395601))
# Output: 46340
