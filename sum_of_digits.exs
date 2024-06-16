# https://leetcode.com/problems/sum-of-digits-of-string-after-convert/
# 1945. Sum of Digits of String After Convert


########################
# https://leetcode.com/problems/happy-number/description/
# 202. Happy Number
# Explanation of the expected solution based on the "Two Pointers" technique:
# https://algo.monster/liteproblems/202


defmodule Solution do
  @spec get_lucky(s :: String.t, k :: integer) :: integer
  def get_lucky(s, k) do
    for <<x <- s>>, reduce: 0 do
      acc -> acc + take_digit_sum(x - ?a + 1, 0)
    end |> do_get_lucky(k - 1)
  end

  defp take_digit_sum(num, out) when num > 0, do: take_digit_sum(div(num, 10), out + rem(num, 10))
  defp take_digit_sum(_, out), do: out

  defp do_get_lucky(tmp, k) when k > 0 and tmp > 9, do: do_get_lucky(take_digit_sum(tmp, 0), k - 1)
  defp do_get_lucky(tmp, _), do: tmp

  @spec is_happy(n :: integer) :: boolean
  def is_happy(n) when n < 1, do: false
  def is_happy(n) do
    do_is_happy(n) == 1
  end

  defp take_square_sum(num, acc) when num > 0, do: take_square_sum(div(num,10), acc + (rem(num,10) ** 2))
  defp take_square_sum(_, acc), do: acc

  defp do_is_happy(n) when n == 1 or n == 4, do: n
  defp do_is_happy(n), do: do_is_happy(take_square_sum(n, 0))


  @spec count_happy_numbers(to_num :: integer) :: integer
  def count_happy_numbers(to_num) do
    IO.inspect("Quantity of Happy Numbers")
    do_count_happy_numbers(to_num, 0)
  end
  defp do_count_happy_numbers(to_num, out) when to_num<1, do: out
  defp do_count_happy_numbers(to_num, out) do
    do_count_happy_numbers(to_num-1, if(is_happy(to_num), do: out+1 , else: out))
  end
end

IO.inspect("Sum of Digits of String After Convert")
IO.inspect(Solution.get_lucky("iiii", 1))
# Output: 36
IO.inspect(Solution.get_lucky("leetcode", 2))
# Output: 6
IO.inspect(Solution.get_lucky("zbax", 2))
# Output: 8

IO.inspect("Happy Number")
IO.inspect(Solution.is_happy(0))
# Output: false
IO.inspect(Solution.is_happy(2))
# Output: false
IO.inspect(Solution.is_happy(2**31 - 1)) # 2147483647
# Output: false
IO.inspect(Solution.is_happy(4722354576))
# Output: false
IO.inspect(Solution.is_happy(9999975))
# Output: false

IO.inspect(Solution.is_happy(7))
# Output: false
IO.inspect(Solution.is_happy(19))
# Output: false
IO.inspect(Solution.is_happy(99924))
# Output: false
IO.inspect(Solution.is_happy(85226))
# Output: false
IO.inspect(Solution.is_happy(72781))
# Output: false
IO.inspect(Solution.is_happy(57052))
# Output: false
IO.inspect(Solution.is_happy(7414))
# Output: false
IO.inspect(Solution.is_happy(9999976))
# Output: false

IO.inspect(Solution.count_happy_numbers(10_000_000))
# Output: 1_418_854 / 10_000_000
