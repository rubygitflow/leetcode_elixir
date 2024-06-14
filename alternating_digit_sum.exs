# https://leetcode.com/problems/alternating-digit-sum/description/
# 2544. Alternating Digit Sum

#############################
# https://leetcode.com/problems/add-digits/description/
# 258. Add Digits
# Explanation: https://algo.monster/liteproblems/258

import Integer

defmodule Solution do
  # Alternating Digit Sum
  @spec alternate_digit_sum(n :: integer) :: integer
  def alternate_digit_sum(n), do: do_alternate_digit_sum(n, 1, 0, 0)

  defp do_alternate_digit_sum(n, negative, digits_num, acc) when n > 0 do
    do_alternate_digit_sum(
      div(n, 10),
      negative * -1,
      digits_num + 1,
      acc + negative * rem(n, 10)
    )
  end
  defp do_alternate_digit_sum(_, _, digits_num, acc) when is_even(digits_num), do: -acc
  defp do_alternate_digit_sum(_, _, _digits_num, acc), do: acc

  # Add Digits
  @spec add_digits(num :: integer) :: integer
  def add_digits(num) when num >= 10 do
    add_digits(
      num
      |> Integer.digits()
      |> Enum.sum
    )
  end
  def add_digits(num), do: num

  @spec add_digits_ii(num :: integer) :: integer
  def add_digits_ii(num) do
    case rem(num-1, 9) do
      x -> x+1
    end
  end
end

IO.inspect("Alternating Digit Sum")
IO.inspect(Solution.alternate_digit_sum(521))
# Output: 4
IO.inspect(Solution.alternate_digit_sum(111))
# Output: 1
IO.inspect(Solution.alternate_digit_sum(886996))
# Output: 0
IO.inspect(Solution.alternate_digit_sum(885996))
# Output: -1
IO.inspect(Solution.alternate_digit_sum(886995))
# Output: 1

IO.inspect("Add Digits (recursion)")
IO.inspect(Solution.add_digits(38))
# Output: 2
IO.inspect(Solution.add_digits(0))
# Output: 0
IO.inspect(Solution.add_digits(886995))
# 8+8+6+9+9+5=45
# 4+5=9
# Output: 9

IO.inspect("Add Digits (digital root - Time complexity: O(1))")
IO.inspect(Solution.add_digits_ii(38))
# Output: 2
IO.inspect(Solution.add_digits_ii(0))
# Output: 0
IO.inspect(Solution.add_digits_ii(886995))
# Output: 9
IO.inspect(Solution.add_digits_ii(1))
# Output: 1
