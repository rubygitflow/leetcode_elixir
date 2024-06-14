# https://leetcode.com/problems/alternating-digit-sum/description/
# 2544. Alternating Digit Sum

import Integer

defmodule Solution do
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
end

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
